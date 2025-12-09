import ballerina/http;
import ballerina/io;

// ============================================
// LEVEL 3+ - DEEPLY NESTED OBJECTS (RequiredLevel: 3)
// ============================================

// Authentication provider configuration
type AuthProvider record {
    string name;
    string clientId;
    string clientSecret;
    int tokenExpiry;
    boolean enabled;
    string[] scopes;
};

// Security configuration with nested auth providers
type SecurityConfig record {
    AuthProvider oauth;
    AuthProvider saml?;
    boolean requireHttps;
    int sessionTimeout;
};

// Service configuration with nested security
type ServiceConfig record {
    SecurityConfig security;
    string serviceName;
    int maxRetries;
    float timeout;
};

// Level 3 deeply nested structure
type Level3Nested record {
    ServiceConfig serviceConfig;
    string environment;
    int replicaCount;
};

// Complex map value type
type MapValueType record {
    string key;
    int value;
    boolean active;
};

// Complex map configuration
type ComplexMapConfig record {
    map<string> simpleStringMap;
    map<int> simpleIntMap;
    map<MapValueType> complexMap;
    map<string[]> arrayMap;
    map<AuthProvider> objectMap;
};

// Base greeting type for complex structures
type NewGreeting record {
    string newfrom;
    string newto;
    string newmessage?;
};

// Database config for advanced structure
type DatabaseConfig record {
    string host;
    int port;
    string username;
    string password?;
    boolean sslEnabled;
    float connectionTimeout;
    decimal maxPoolSize;
    string[] allowedHosts;
    int[] ports;
};

// Cache config for advanced structure
type CacheConfig record {
    string cacheType;
    int ttl;
    boolean enabled;
    float memoryLimit;
    string[] evictionPolicies;
};

// Level 2 nested for embedding in advanced config
type Level2Nested record {
    DatabaseConfig database;
    CacheConfig cache;
    string appName;
    int appVersion;
};

// Flexible config with union types
type FlexibleConfig record {
    string|int flexibleValue;
    string|null nullableString?;
    int|float numericValue;
    boolean|string mixedValue;
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
    NewGreeting[] objectArray;
    map<string>[] mapArray;
    string[][] nestedStringArray;
    int[][] nestedIntArray;
};

// Advanced configuration combining all levels
type AdvancedConfig record {
    // Level 1 primitives
    string apiKey;
    int maxConnections;
    float rateLimit;
    decimal precision;
    boolean debugMode;
    
    // Level 2 nested
    Level2Nested nested;
    
    // Level 3+ deeply nested
    Level3Nested deepNested?;
    
    // Arrays
    string[] endpoints;
    int[] ports;
    NewGreeting[] greetings;
    
    // Maps
    map<string> envVars;
    map<int> thresholds;
    map<NewGreeting> configMap;
    
    // Union types
    FlexibleConfig flexible?;
    
    // Enum
    LoggingConfig logging;
    
    // Complex arrays
    ArrayConfig arrays;
    
    // Complex maps
    ComplexMapConfig maps;
};

// ============================================
// LEVEL 3 CONFIGURABLE VARIABLES
// ============================================

// Level 3 deeply nested configuration
configurable Level3Nested level3Config = {
    serviceConfig: {
        security: {
            oauth: {
                name: "",
                clientId: "",
                clientSecret: "",
                tokenExpiry: 0,
                enabled: false,
                scopes: []
            },
            requireHttps: false,
            sessionTimeout: 0
        },
        serviceName: "",
        maxRetries: 0,
        timeout: 0.0
    },
    environment: "",
    replicaCount: 0
};

// Complex map configuration
configurable ComplexMapConfig mapConfig = {
    simpleStringMap: {},
    simpleIntMap: {},
    complexMap: {},
    arrayMap: {},
    objectMap: {}
};

// Advanced configuration with all levels
configurable AdvancedConfig advancedConfig = {
    apiKey: "",
    maxConnections: 0,
    rateLimit: 0.0,
    precision: 0.0,
    debugMode: false,
    nested: {
        database: {
            host: "",
            port: 0,
            username: "",
            sslEnabled: false,
            connectionTimeout: 0.0,
            maxPoolSize: 0.0,
            allowedHosts: [],
            ports: []
        },
        cache: {
            cacheType: "",
            ttl: 0,
            enabled: false,
            memoryLimit: 0.0,
            evictionPolicies: []
        },
        appName: "",
        appVersion: 0
    },
    deepNested: {
        serviceConfig: {
            security: {
                oauth: {
                    name: "",
                    clientId: "",
                    clientSecret: "",
                    tokenExpiry: 0,
                    enabled: false,
                    scopes: []
                },
                requireHttps: false,
                sessionTimeout: 0
            },
            serviceName: "",
            maxRetries: 0,
            timeout: 0.0
        },
        environment: "",
        replicaCount: 0
    },
    endpoints: [],
    ports: [],
    greetings: [],
    envVars: {},
    thresholds: {},
    configMap: {},
    flexible: {
        flexibleValue: "",
        numericValue: 0,
        mixedValue: ""
    },
    logging: {
        level: DEBUG,
        format: "",
        maxFiles: 0
    },
    arrays: {
        stringArray: [],
        intArray: [],
        floatArray: [],
        booleanArray: [],
        objectArray: [],
        mapArray: [],
        nestedStringArray: [],
        nestedIntArray: []
    },
    maps: {
        simpleStringMap: {},
        simpleIntMap: {},
        complexMap: {},
        arrayMap: {},
        objectMap: {}
    }
};

// ============================================
// SERVICE
// ============================================
service / on new http:Listener(8092) {
    resource function get level3(string name) returns json {
        io:println("=== Level 3 Configurations ===");
        io:println("Deeply Nested Objects:");
        io:println("  - Service Config: ", level3Config.serviceConfig);
        io:println("  - Environment: ", level3Config.environment);
        io:println("  - Replica Count: ", level3Config.replicaCount);
        io:println("\nAdvanced Config:");
        io:println("  - API Key: ", advancedConfig.apiKey);
        io:println("  - Deep Nested: ", advancedConfig.deepNested);
        
        // Return Level 3 configurables as JSON
        json response = {
            "level": 3,
            "description": "Deeply nested objects with multiple levels of nesting",
            "configurations": {
                "level3Config": level3Config.toJson(),
                "mapConfig": mapConfig.toJson(),
                "advancedConfig": advancedConfig.toJson()
            },
            "requestName": name
        };
        
        return response;
    }
}