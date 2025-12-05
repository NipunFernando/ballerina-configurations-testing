import ballerina/http;
import ballerina/io;

// ============================================
// SCHEMA ISSUE REPRODUCTION - MINIMAL TEST
// ============================================

// Database config (Level 2)
type DatabaseConfig record {
    string host;
    int port;
    string username;
    boolean sslEnabled;
};

// Cache config (Level 2)
type CacheConfig record {
    string cacheType;
    int ttl;
    boolean enabled;
};

// Level 2 nested structure
type Level2Nested record {
    DatabaseConfig database;
    CacheConfig cache;
    string appName;
    int appVersion;
};

// Logging levels enum
enum LogLevel {
    DEBUG,
    INFO,
    WARN,
    ERROR
}

// Logging configuration
type LoggingConfig record {
    LogLevel level;
    string format;
    int maxFiles;
};

// Array configuration
type ArrayConfig record {
    string[] stringArray;
    int[] intArray;
    float[] floatArray;
    boolean[] booleanArray;
    string[][] nestedStringArray;
};

// Advanced configuration with nested structure (OPTIONAL - has defaults)
type AdvancedConfig record {
    // Level 1 primitives
    string apiKey;
    int maxConnections;
    float rateLimit;
    decimal precision;
    boolean debugMode;
    
    // Level 2 nested
    Level2Nested nested;
    
    // Arrays (primitives only)
    string[] endpoints;
    int[] ports;
    
    // Maps (primitives only)
    map<string> envVars;
    
    // Enum
    LoggingConfig logging;
    
    // Complex arrays
    ArrayConfig arrays;
};

// ============================================
// CONFIGURABLE VARIABLES
// ============================================

// REQUIRED Configurable 1: Simple string
configurable string requiredString = ?;

// REQUIRED Configurable 2: Simple int
configurable int requiredInt = ?;

// OPTIONAL Configurable: Advanced config with defaults (should be optional but schema marks as required)
configurable AdvancedConfig advancedConfig = {
    apiKey: "default_api_key",
    maxConnections: 100,
    rateLimit: 10.5,
    precision: 0.001,
    debugMode: false,
    nested: {
        database: {
            host: "default-db",
            port: 5432,
            username: "default_user",
            sslEnabled: false
        },
        cache: {
            cacheType: "memory",
            ttl: 3600,
            enabled: true
        },
        appName: "DefaultApp",
        appVersion: 1
    },
    endpoints: ["http://localhost:8080"],
    ports: [8080, 8081],
    envVars: {"ENV": "development"},
    logging: {
        level: INFO,
        format: "json",
        maxFiles: 10
    },
    arrays: {
        stringArray: ["default"],
        intArray: [1, 2, 3],
        floatArray: [1.1, 2.2],
        booleanArray: [true, false],
        nestedStringArray: [["a", "b"]]
    }
};

// ============================================
// SERVICE
// ============================================
service / on new http:Listener(8093) {
    
    resource function get test() returns json {
        io:println("\n========================================");
        io:println("SCHEMA ISSUE REPRODUCTION TEST");
        io:println("========================================\n");
        
        io:println("--- REQUIRED CONFIGS ---");
        io:println("requiredString: ", requiredString);
        io:println("requiredInt: ", requiredInt);
        
        io:println("\n--- OPTIONAL CONFIG (with defaults) ---");
        io:println("advancedConfig.apiKey: ", advancedConfig.apiKey);
        io:println("advancedConfig.maxConnections: ", advancedConfig.maxConnections);
        io:println("advancedConfig.rateLimit: ", advancedConfig.rateLimit);
        io:println("advancedConfig.precision: ", advancedConfig.precision.toString());
        io:println("advancedConfig.debugMode: ", advancedConfig.debugMode);
        io:println("advancedConfig.nested.appName: ", advancedConfig.nested.appName);
        io:println("advancedConfig.nested.database.host: ", advancedConfig.nested.database.host);
        io:println("advancedConfig.nested.cache.cacheType: ", advancedConfig.nested.cache.cacheType);
        io:println("advancedConfig.endpoints: ", advancedConfig.endpoints);
        io:println("advancedConfig.ports: ", advancedConfig.ports);
        io:println("advancedConfig.envVars: ", advancedConfig.envVars);
        io:println("advancedConfig.logging.level: ", advancedConfig.logging.level.toString());
        io:println("advancedConfig.arrays.stringArray: ", advancedConfig.arrays.stringArray);
        
        io:println("\n========================================");
        io:println("ISSUE: Even though advancedConfig has defaults,");
        io:println("Choreo config-schema.json marks all fields as required:");
        io:println("  - apiKey, maxConnections, rateLimit, precision, debugMode");
        io:println("  - nested, endpoints, ports, envVars, logging, arrays");
        io:println("========================================\n");
        
        json response = {
            "message": "Schema Issue Reproduction Test",
            "requiredConfigs": {
                "requiredString": requiredString,
                "requiredInt": requiredInt
            },
            "optionalConfig": {
                "apiKey": advancedConfig.apiKey,
                "maxConnections": advancedConfig.maxConnections,
                "rateLimit": advancedConfig.rateLimit,
                "precision": advancedConfig.precision.toString(),
                "debugMode": advancedConfig.debugMode,
                "nested": {
                    "appName": advancedConfig.nested.appName,
                    "database": {
                        "host": advancedConfig.nested.database.host,
                        "port": advancedConfig.nested.database.port
                    },
                    "cache": {
                        "cacheType": advancedConfig.nested.cache.cacheType,
                        "enabled": advancedConfig.nested.cache.enabled
                    }
                },
                "endpoints": advancedConfig.endpoints,
                "ports": advancedConfig.ports,
                "envVars": advancedConfig.envVars,
                "logging": {
                    "level": advancedConfig.logging.level.toString(),
                    "format": advancedConfig.logging.format
                },
                "arrays": {
                    "stringArray": advancedConfig.arrays.stringArray,
                    "intArray": advancedConfig.arrays.intArray
                }
            },
            "issue": "advancedConfig has defaults but Choreo schema marks all fields as required",
            "expectedBehavior": "advancedConfig fields should be optional in schema since defaults are provided"
        };
        
        return response;
    }
}
