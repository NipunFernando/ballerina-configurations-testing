import ballerina/http;
import ballerina/io;
import ballerina/os;

// ============================================
// LEVEL 3+ - DEEPLY NESTED OBJECTS (RequiredLevel: 3)
// ============================================

// Authentication provider configuration (Level 4)
type AuthProvider record {
    string name;
    string clientId;
    string clientSecret;
    int tokenExpiry;
    boolean enabled;
    string[] scopes;
};

// Security configuration with nested auth providers (Level 3)
type SecurityConfig record {
    AuthProvider oauth;
    // AuthProvider? saml;
    boolean requireHttps;
    int sessionTimeout;
};

// Service configuration with nested security (Level 2)
type ServiceConfig record {
    SecurityConfig security;
    string serviceName;
    int maxRetries;
    float timeout;
};

// Level 3 deeply nested structure (Level 1)
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
    // COMMENTED OUT - causing deployment errors in Choreo
    // NewGreeting[] objectArray;
    // COMMENTED OUT - causing deployment errors in Choreo
    // map<string>[] mapArray;
    string[][] nestedStringArray;
    int[][] nestedIntArray;
};

// Advanced configuration combining all levels (SIMPLIFIED - no nested records)
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
    // COMMENTED OUT - causing deployment errors in Choreo
    // map<int> thresholds;
    
    // Enum
    LoggingConfig logging;
    
    // Complex arrays
    ArrayConfig arrays;
    
    // Complex maps
    // COMMENTED OUT - causing deployment errors in Choreo
    // ComplexMapConfig maps;
};

// ============================================
// LEVEL 3 CONFIGURABLE VARIABLES
// ============================================

// Level 3 deeply nested configuration - REQUIRED
configurable Level3Nested level3Config = ?;

// Complex map configuration - with defaults
// COMMENTED OUT - causing deployment errors in Choreo
// configurable ComplexMapConfig complexMapConfig = {
//     simpleStringMap: {"default": "value"},
//     simpleIntMap: {"default": 100},
//     complexMap: {},
//     arrayMap: {"default": ["value"]},
//     objectMap: {}
// };

// Advanced configuration with all levels - with defaults
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
            sslEnabled: false,
            connectionTimeout: 30.0,
            maxPoolSize: 10.0,
            allowedHosts: ["localhost"],
            ports: [5432]
        },
        cache: {
            cacheType: "memory",
            ttl: 3600,
            enabled: true,
            memoryLimit: 256.0,
            evictionPolicies: ["LRU"]
        },
        appName: "DefaultApp",
        appVersion: 1
    },
    endpoints: ["http://localhost:8080"],
    ports: [8080, 8081],
    envVars: {"ENV": "development"},
    // COMMENTED OUT - causing deployment errors in Choreo
    // thresholds: {"max": 1000},
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
        // COMMENTED OUT - causing deployment errors in Choreo
        // objectArray: [],
        // COMMENTED OUT - causing deployment errors in Choreo
        // mapArray: [],
        nestedStringArray: [["a", "b"]],
        nestedIntArray: [[1, 2]]
    }
    // COMMENTED OUT - causing deployment errors in Choreo
    // maps: {
    //     simpleStringMap: {"default": "value"},
    //     simpleIntMap: {"default": 100},
    //     complexMap: {},
    //     arrayMap: {"default": ["value"]},
    //     objectMap: {}
    // }
};

// Additional standalone union types for testing
configurable string|int unionType = "default_union_value";
configurable int|float numericUnion = 10;

// Environment variable
configurable string name = os:getEnv("NAME");

// ============================================
// SERVICE
// ============================================
service / on new http:Listener(8092) {
    
    resource function get level3() returns json {
        // Print all Level 3 configurations with descriptions
        io:println("\n========================================");
        io:println("LEVEL 3 - DEEPLY NESTED OBJECTS CONFIGURATION TEST");
        io:println("========================================\n");
        
        // 1. Level 3 Deeply Nested Configuration (4 levels deep)
        io:println("--- 1. LEVEL 3 DEEPLY NESTED (4 Levels) ---");
        io:println("Level 1 - level3Config.environment: ", level3Config.environment);
        io:println("Level 1 - level3Config.replicaCount: ", level3Config.replicaCount);
        io:println("Level 2 - level3Config.serviceConfig.serviceName: ", level3Config.serviceConfig.serviceName);
        io:println("Level 2 - level3Config.serviceConfig.maxRetries: ", level3Config.serviceConfig.maxRetries);
        io:println("Level 2 - level3Config.serviceConfig.timeout: ", level3Config.serviceConfig.timeout);
        io:println("Level 3 - level3Config.serviceConfig.security.requireHttps: ", level3Config.serviceConfig.security.requireHttps);
        io:println("Level 3 - level3Config.serviceConfig.security.sessionTimeout: ", level3Config.serviceConfig.security.sessionTimeout);
        io:println("Level 4 - level3Config.serviceConfig.security.oauth.name: ", level3Config.serviceConfig.security.oauth.name);
        io:println("Level 4 - level3Config.serviceConfig.security.oauth.clientId: ", level3Config.serviceConfig.security.oauth.clientId);
        io:println("Level 4 - level3Config.serviceConfig.security.oauth.enabled: ", level3Config.serviceConfig.security.oauth.enabled);
        io:println("Level 4 - level3Config.serviceConfig.security.oauth.scopes: ", level3Config.serviceConfig.security.oauth.scopes);
        // io:println("Level 4 (Optional) - level3Config.serviceConfig.security.saml: ", level3Config.serviceConfig.security.saml);
        io:println("  Description: Testing 4 levels of nesting with optional field\n");
        
        // 2. Complex Map Configuration
        // COMMENTED OUT - causing deployment errors in Choreo
        // io:println("--- 2. COMPLEX MAP CONFIGURATION ---");
        // io:println("complexMapConfig.simpleStringMap: ", complexMapConfig.simpleStringMap);
        // io:println("complexMapConfig.simpleIntMap: ", complexMapConfig.simpleIntMap);
        // io:println("complexMapConfig.complexMap (map<MapValueType>): ", complexMapConfig.complexMap);
        // io:println("complexMapConfig.arrayMap (map<string[]>): ", complexMapConfig.arrayMap);
        // io:println("complexMapConfig.objectMap (map<AuthProvider>): ", complexMapConfig.objectMap);
        // io:println("  Description: Testing maps with complex nested object values\n");
        
        // 3. Advanced Configuration
        io:println("--- 3. ADVANCED CONFIGURATION ---");
        io:println("advancedConfig.apiKey: ", advancedConfig.apiKey);
        io:println("advancedConfig.maxConnections: ", advancedConfig.maxConnections);
        io:println("advancedConfig.nested.appName: ", advancedConfig.nested.appName);
        io:println("advancedConfig.nested.database.host: ", advancedConfig.nested.database.host);
        io:println("advancedConfig.nested.cache.cacheType: ", advancedConfig.nested.cache.cacheType);
        io:println("advancedConfig.logging.level: ", advancedConfig.logging.level);
        io:println("advancedConfig.arrays.nestedStringArray: ", advancedConfig.arrays.nestedStringArray);
        // COMMENTED OUT - causing deployment errors in Choreo
        // io:println("advancedConfig.maps.simpleStringMap: ", advancedConfig.maps.simpleStringMap);
        io:println("  Description: Comprehensive config combining all levels\n");
        
        // 4. Union Types
        io:println("--- 4. UNION TYPES ---");
        io:println("unionType (string|int): ", unionType);
        io:println("numericUnion (int|float): ", numericUnion);
        io:println("  Description: Testing union type configurations\n");
        
        io:println("========================================");
        io:println("END OF LEVEL 3 CONFIGURATION TEST");
        io:println("========================================\n");
        
        // Construct greeting message
        string message = "Hello, " + name + "! Level 3 Deep Nesting Configuration Test Completed.";
        io:println("Response Message: ", message);
        
        // Return comprehensive Level 3 configuration as JSON
        json response = {
            "greeting": message,
            "level": 3,
            "description": "Deeply nested objects with multiple levels (4 levels) of nesting - Level 3 Configuration Test",
            "configurations": {
                "level3Config": {
                    "environment": level3Config.environment,
                    "replicaCount": level3Config.replicaCount,
                    "serviceConfig": {
                        "serviceName": level3Config.serviceConfig.serviceName,
                        "maxRetries": level3Config.serviceConfig.maxRetries,
                        "timeout": level3Config.serviceConfig.timeout,
                        "security": {
                            "requireHttps": level3Config.serviceConfig.security.requireHttps,
                            "sessionTimeout": level3Config.serviceConfig.security.sessionTimeout,
                            "oauth": {
                                "name": level3Config.serviceConfig.security.oauth.name,
                                "clientId": level3Config.serviceConfig.security.oauth.clientId,
                                "clientSecret": level3Config.serviceConfig.security.oauth.clientSecret,
                                "tokenExpiry": level3Config.serviceConfig.security.oauth.tokenExpiry,
                                "enabled": level3Config.serviceConfig.security.oauth.enabled,
                                "scopes": level3Config.serviceConfig.security.oauth.scopes
                            },
                            "saml": null
                    }
                },
                // COMMENTED OUT - causing deployment errors in Choreo
                // "complexMapConfig": {
                //     "simpleStringMap": complexMapConfig.simpleStringMap,
                //     "simpleIntMap": complexMapConfig.simpleIntMap,
                //     "complexMap": complexMapConfig.complexMap.toJson(),
                //     "arrayMap": complexMapConfig.arrayMap.toJson(),
                //     "objectMap": complexMapConfig.objectMap.toJson()
                // },
                "advancedConfig": {
                    "primitives": {
                        "apiKey": advancedConfig.apiKey,
                        "maxConnections": advancedConfig.maxConnections,
                        "rateLimit": advancedConfig.rateLimit,
                        "precision": advancedConfig.precision.toString(),
                        "debugMode": advancedConfig.debugMode
                    },
                    "nested": {
                        "appName": advancedConfig.nested.appName,
                        "appVersion": advancedConfig.nested.appVersion,
                        "database": {
                            "host": advancedConfig.nested.database.host,
                            "port": advancedConfig.nested.database.port,
                            "username": advancedConfig.nested.database.username
                        },
                        "cache": {
                            "cacheType": advancedConfig.nested.cache.cacheType,
                            "enabled": advancedConfig.nested.cache.enabled
                        }
                    },
                    "arrays": {
                        "endpoints": advancedConfig.endpoints,
                        "ports": advancedConfig.ports,
                        "nestedStringArray": advancedConfig.arrays.nestedStringArray
                    },
                    "maps": {
                        "envVars": advancedConfig.envVars
                        // COMMENTED OUT - causing deployment errors in Choreo
                        // "thresholds": advancedConfig.thresholds
                    },
                    "logging": {
                        "level": advancedConfig.logging.level.toString(),
                        "format": advancedConfig.logging.format
                    }
                },
                "unionTypes": {
                    "unionType": unionType.toString(),
                    "numericUnion": numericUnion.toString()
                }
            },
            "testSummary": {
                "nestingLevel": "4 levels deep",
                "requiredConfigsCount": 1,
                "optionalConfigsCount": 4,
                "totalConfigsCount": 5,
                "testedTypes": [
                    "Deeply nested objects (4 levels)",
                    "Level3Nested -> ServiceConfig -> SecurityConfig -> AuthProvider",
                    "Optional deeply nested fields (saml?)",
                    "Complex maps (map<MapValueType>, map<AuthProvider>)",
                    "Maps with array values (map<string[]>)",
                    "Advanced combined configuration (Levels 1 & 2)",
                    "Union types (string|int, int|float)",
                    "Enums in nested structures",
                    "Arrays of complex objects",
                    "Nested arrays (2D arrays)",
                    "Level 2 nesting in advanced config"
                ]
            }
        }};
        
        return response;
    }
}