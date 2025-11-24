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
    AuthProvider? saml;
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
    Level3Nested? deepNested;
    
    // Arrays
    string[] endpoints;
    int[] ports;
    NewGreeting[] greetings;
    
    // Maps
    map<string> envVars;
    map<int> thresholds;
    map<NewGreeting> configMap;
    
    // Union types
    FlexibleConfig? flexible;
    
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

// Level 3 deeply nested configuration - REQUIRED
configurable Level3Nested level3Config = ?;

// Complex map configuration - with defaults
configurable ComplexMapConfig complexMapConfig = {
    simpleStringMap: {"default": "value"},
    simpleIntMap: {"default": 100},
    complexMap: {},
    arrayMap: {},
    objectMap: {}
};

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
    greetings: [],
    envVars: {"ENV": "development"},
    thresholds: {"max": 1000},
    configMap: {},
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
        objectArray: [],
        mapArray: [],
        nestedStringArray: [["a", "b"]],
        nestedIntArray: [[1, 2]]
    },
    maps: {
        simpleStringMap: {"default": "value"},
        simpleIntMap: {"default": 100},
        complexMap: {},
        arrayMap: {},
        objectMap: {}
    }
};

// Environment variable for the name
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
        
        // 1. Level 3 Deeply Nested Configuration
        io:println("--- 1. LEVEL 3 DEEPLY NESTED CONFIGURATION (Required) ---");
        io:println("level3Config.environment: ", level3Config.environment);
        io:println("level3Config.replicaCount: ", level3Config.replicaCount);
        io:println("  Description: Level 1 - Root object\n");
        
        // 1a. Service Config (Level 2)
        io:println("--- 1a. SERVICE CONFIG (Level 2) ---");
        io:println("level3Config.serviceConfig.serviceName: ", level3Config.serviceConfig.serviceName);
        io:println("level3Config.serviceConfig.maxRetries: ", level3Config.serviceConfig.maxRetries);
        io:println("level3Config.serviceConfig.timeout: ", level3Config.serviceConfig.timeout);
        io:println("  Description: Level 2 - Nested inside Level3Nested\n");
        
        // 1b. Security Config (Level 3)
        io:println("--- 1b. SECURITY CONFIG (Level 3) ---");
        io:println("level3Config.serviceConfig.security.requireHttps: ", level3Config.serviceConfig.security.requireHttps);
        io:println("level3Config.serviceConfig.security.sessionTimeout: ", level3Config.serviceConfig.security.sessionTimeout);
        io:println("  Description: Level 3 - Nested inside ServiceConfig\n");
        
        // 1c. OAuth Auth Provider (Level 4)
        io:println("--- 1c. OAUTH AUTH PROVIDER (Level 4) ---");
        io:println("level3Config.serviceConfig.security.oauth.name: ", level3Config.serviceConfig.security.oauth.name);
        io:println("level3Config.serviceConfig.security.oauth.clientId: ", level3Config.serviceConfig.security.oauth.clientId);
        io:println("level3Config.serviceConfig.security.oauth.clientSecret: ", level3Config.serviceConfig.security.oauth.clientSecret);
        io:println("level3Config.serviceConfig.security.oauth.tokenExpiry: ", level3Config.serviceConfig.security.oauth.tokenExpiry);
        io:println("level3Config.serviceConfig.security.oauth.enabled: ", level3Config.serviceConfig.security.oauth.enabled);
        io:println("level3Config.serviceConfig.security.oauth.scopes: ", level3Config.serviceConfig.security.oauth.scopes);
        io:println("  Description: Level 4 - Deeply nested inside SecurityConfig\n");
        
        // 1d. SAML Auth Provider (Optional, Level 4)
        io:println("--- 1d. SAML AUTH PROVIDER (Optional, Level 4) ---");
        io:println("level3Config.serviceConfig.security.saml: ", level3Config.serviceConfig.security.saml);
        io:println("  Description: Level 4 - Optional deeply nested auth provider\n");
        
        // 2. Complex Map Configuration
        io:println("--- 2. COMPLEX MAP CONFIGURATION ---");
        io:println("complexMapConfig.simpleStringMap: ", complexMapConfig.simpleStringMap);
        io:println("  Description: Simple map with string values");
        io:println("complexMapConfig.simpleIntMap: ", complexMapConfig.simpleIntMap);
        io:println("  Description: Simple map with int values");
        io:println("complexMapConfig.complexMap: ", complexMapConfig.complexMap);
        io:println("  Description: Map with complex object values (MapValueType)");
        io:println("complexMapConfig.arrayMap: ", complexMapConfig.arrayMap);
        io:println("  Description: Map with array values (map<string[]>)");
        io:println("complexMapConfig.objectMap: ", complexMapConfig.objectMap);
        io:println("  Description: Map with AuthProvider object values\n");
        
        // 3. Advanced Configuration - Primitives
        io:println("--- 3. ADVANCED CONFIG - PRIMITIVES ---");
        io:println("advancedConfig.apiKey: ", advancedConfig.apiKey);
        io:println("advancedConfig.maxConnections: ", advancedConfig.maxConnections);
        io:println("advancedConfig.rateLimit: ", advancedConfig.rateLimit);
        io:println("advancedConfig.precision: ", advancedConfig.precision);
        io:println("advancedConfig.debugMode: ", advancedConfig.debugMode);
        io:println("  Description: Level 1 primitives in advanced config\n");
        
        // 4. Advanced Configuration - Level 2 Nested
        io:println("--- 4. ADVANCED CONFIG - LEVEL 2 NESTED ---");
        io:println("advancedConfig.nested.appName: ", advancedConfig.nested.appName);
        io:println("advancedConfig.nested.appVersion: ", advancedConfig.nested.appVersion);
        io:println("advancedConfig.nested.database.host: ", advancedConfig.nested.database.host);
        io:println("advancedConfig.nested.cache.cacheType: ", advancedConfig.nested.cache.cacheType);
        io:println("  Description: Level 2 nested objects in advanced config\n");
        
        // 5. Advanced Configuration - Level 3+ Deep Nested (Optional)
        io:println("--- 5. ADVANCED CONFIG - LEVEL 3+ DEEP NESTED (Optional) ---");
        io:println("advancedConfig.deepNested: ", advancedConfig.deepNested);
        io:println("  Description: Optional Level 3+ deeply nested structure\n");
        
        // 6. Advanced Configuration - Arrays
        io:println("--- 6. ADVANCED CONFIG - ARRAYS ---");
        io:println("advancedConfig.endpoints: ", advancedConfig.endpoints);
        io:println("advancedConfig.ports: ", advancedConfig.ports);
        io:println("advancedConfig.greetings: ", advancedConfig.greetings);
        io:println("advancedConfig.arrays.stringArray: ", advancedConfig.arrays.stringArray);
        io:println("advancedConfig.arrays.nestedStringArray: ", advancedConfig.arrays.nestedStringArray);
        io:println("  Description: Various array types in advanced config\n");
        
        // 7. Advanced Configuration - Maps
        io:println("--- 7. ADVANCED CONFIG - MAPS ---");
        io:println("advancedConfig.envVars: ", advancedConfig.envVars);
        io:println("advancedConfig.thresholds: ", advancedConfig.thresholds);
        io:println("advancedConfig.configMap: ", advancedConfig.configMap);
        io:println("  Description: Various map types in advanced config\n");
        
        // 8. Advanced Configuration - Enum
        io:println("--- 8. ADVANCED CONFIG - ENUM ---");
        io:println("advancedConfig.logging.level: ", advancedConfig.logging.level);
        io:println("advancedConfig.logging.format: ", advancedConfig.logging.format);
        io:println("  Description: Enum-based logging configuration\n");
        
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
            "description": "Deeply nested objects with multiple levels (3+) of nesting - Level 3 Configuration Test",
            "configurations": {
                "level3Nested": {
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
                            "saml": level3Config.serviceConfig.security.saml.toJson()
                        }
                    }
                },
                "complexMapConfig": {
                    "simpleStringMap": complexMapConfig.simpleStringMap,
                    "simpleIntMap": complexMapConfig.simpleIntMap,
                    "complexMap": complexMapConfig.complexMap.toJson(),
                    "arrayMap": complexMapConfig.arrayMap.toJson(),
                    "objectMap": complexMapConfig.objectMap.toJson()
                },
                "advancedConfig": {
                    "primitives": {
                        "apiKey": advancedConfig.apiKey,
                        "maxConnections": advancedConfig.maxConnections,
                        "rateLimit": advancedConfig.rateLimit,
                        "precision": advancedConfig.precision.toString(),
                        "debugMode": advancedConfig.debugMode
                    },
                    "level2Nested": {
                        "appName": advancedConfig.nested.appName,
                        "appVersion": advancedConfig.nested.appVersion,
                        "database": {
                            "host": advancedConfig.nested.database.host,
                            "port": advancedConfig.nested.database.port
                        },
                        "cache": {
                            "cacheType": advancedConfig.nested.cache.cacheType,
                            "enabled": advancedConfig.nested.cache.enabled
                        }
                    },
                    "deepNested": advancedConfig.deepNested.toJson(),
                    "arrays": {
                        "endpoints": advancedConfig.endpoints,
                        "ports": advancedConfig.ports,
                        "greetings": advancedConfig.greetings.toJson()
                    },
                    "maps": {
                        "envVars": advancedConfig.envVars,
                        "thresholds": advancedConfig.thresholds,
                        "configMap": advancedConfig.configMap.toJson()
                    },
                    "logging": {
                        "level": advancedConfig.logging.level.toString(),
                        "format": advancedConfig.logging.format,
                        "maxFiles": advancedConfig.logging.maxFiles
                    }
                }
            },
            "testSummary": {
                "nestingLevel": "3+ levels deep (4 levels)",
                "requiredConfigsCount": 1,
                "optionalConfigsCount": 2,
                "totalConfigsCount": 3,
                "testedTypes": [
                    "Deeply nested objects (4 levels)",
                    "Level3Nested -> ServiceConfig -> SecurityConfig -> AuthProvider",
                    "Optional deeply nested fields (saml?)",
                    "Complex maps (map<MapValueType>, map<AuthProvider>)",
                    "Maps with array values (map<string[]>)",
                    "Advanced combined configuration (all levels)",
                    "Union types in nested contexts",
                    "Enums in nested structures",
                    "Arrays of complex objects",
                    "Nested arrays (2D arrays)",
                    "Maps of complex objects",
                    "Optional Level 3+ nested structures"
                ]
            }
        };
        
        return response;
    }
}