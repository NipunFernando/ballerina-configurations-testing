import ballerina/http;
import ballerina/io;
import ballerina/os;

// ============================================
// LEVEL 2 - NESTED OBJECTS (RequiredLevel: 2)
// ============================================

// Database configuration with multiple nested fields
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

// Cache configuration with various types
type CacheConfig record {
    string cacheType;
    int ttl;
    boolean enabled;
    float memoryLimit;
    string[] evictionPolicies;
};

// Level 2 nested structure combining multiple configs
type Level2Nested record {
    DatabaseConfig database;
    CacheConfig cache;
    string appName;
    int appVersion;
};

// Simple greeting type for testing
type NewGreeting record {
    string newfrom;
    string newto;
    string newmessage?;
};

// Flexible configuration with union types
type FlexibleConfig record {
    string|int flexibleValue;
    string|null nullableString?;
    int|float numericValue;
    boolean|string mixedValue;
};

// Enum for logging levels
enum LogLevel {
    DEBUG,
    INFO,
    WARN,
    ERROR
}

// Logging configuration using enum
type LoggingConfig record {
    LogLevel level;
    string format;
    int maxFiles;
};

// Arrays of different types configuration
type ArrayConfig record {
    string[] stringArray;
    int[] intArray;
    float[] floatArray;
    boolean[] booleanArray;
    DatabaseConfig[] objectArray;
    map<string>[] mapArray;
    string[][] nestedStringArray;
    int[][] nestedIntArray;
};

// Map configuration with complex types
type MapConfig record {
    map<string> stringMap;
    map<int> intMap;
    map<float> floatMap;
    map<boolean> booleanMap;
    map<DatabaseConfig> objectMap = {};
};

// ============================================
// LEVEL 2 CONFIGURABLE VARIABLES
// ============================================

// Main Level 2 nested configuration - REQUIRED
configurable Level2Nested level2Config = ?;

// Flexible configuration with union types - with defaults
configurable FlexibleConfig flexibleConfig = {
    flexibleValue: "default_string",
    numericValue: 42,
    mixedValue: true
};

// Logging configuration with enum - with defaults
configurable LoggingConfig loggingConfig = {
    level: INFO,
    format: "json",
    maxFiles: 10
};

// Array configuration - with defaults
configurable ArrayConfig arrayConfig = {
    stringArray: ["default1", "default2"],
    intArray: [1, 2, 3],
    floatArray: [1.1, 2.2],
    booleanArray: [true, false],
    objectArray: [],
    mapArray: [],
    nestedStringArray: [["a", "b"], ["c", "d"]],
    nestedIntArray: [[1, 2], [3, 4]]
};

// Map configuration - with defaults
configurable MapConfig mapConfig = {
    stringMap: {"default_key": "default_value"},
    intMap: {"default": 100},
    floatMap: {"default": 1.5},
    booleanMap: {"default": true},
    objectMap: {}
};

// Additional Level 2 specific tests
configurable string|int unionType = "default_union_value";
configurable string|null nullableUnion = "not_null";
configurable int|float numericUnion = 10;
configurable boolean|string mixedUnion = "string_value";

// Environment variable for the name
configurable string name = os:getEnv("NAME");

// ============================================
// SERVICE
// ============================================

service / on new http:Listener(8091) {
    
    resource function get level2() returns json {
        // Print all Level 2 configurations with descriptions
        io:println("\n========================================");
        io:println("LEVEL 2 - NESTED OBJECTS CONFIGURATION TEST");
        io:println("========================================\n");
        
        // 1. Main Level 2 Nested Configuration
        io:println("--- 1. LEVEL 2 NESTED CONFIGURATION (Required) ---");
        io:println("level2Config.appName: ", level2Config.appName);
        io:println("level2Config.appVersion: ", level2Config.appVersion);
        io:println("  Description: Parent object with nested child objects\n");
        
        // 1a. Nested Database Config
        io:println("--- 1a. DATABASE CONFIG (Nested - Level 1) ---");
        io:println("level2Config.database.host: ", level2Config.database.host);
        io:println("level2Config.database.port: ", level2Config.database.port);
        io:println("level2Config.database.username: ", level2Config.database.username);
        io:println("level2Config.database.password: ", level2Config.database.password);
        io:println("level2Config.database.sslEnabled: ", level2Config.database.sslEnabled);
        io:println("level2Config.database.connectionTimeout: ", level2Config.database.connectionTimeout);
        io:println("level2Config.database.maxPoolSize: ", level2Config.database.maxPoolSize);
        io:println("level2Config.database.allowedHosts: ", level2Config.database.allowedHosts);
        io:println("level2Config.database.ports: ", level2Config.database.ports);
        io:println("  Description: One level deep - object containing primitives and arrays\n");
        
        // 1b. Nested Cache Config
        io:println("--- 1b. CACHE CONFIG (Nested - Level 1) ---");
        io:println("level2Config.cache.cacheType: ", level2Config.cache.cacheType);
        io:println("level2Config.cache.ttl: ", level2Config.cache.ttl);
        io:println("level2Config.cache.enabled: ", level2Config.cache.enabled);
        io:println("level2Config.cache.memoryLimit: ", level2Config.cache.memoryLimit);
        io:println("level2Config.cache.evictionPolicies: ", level2Config.cache.evictionPolicies);
        io:println("  Description: One level deep - object containing primitives and arrays\n");
        
        // 2. Union Types
        io:println("--- 2. UNION TYPES ---");
        io:println("flexibleConfig.flexibleValue (string|int): ", flexibleConfig.flexibleValue);
        io:println("flexibleConfig.nullableString (string|null): ", flexibleConfig?.nullableString);
        io:println("flexibleConfig.numericValue (int|float): ", flexibleConfig.numericValue);
        io:println("flexibleConfig.mixedValue (boolean|string): ", flexibleConfig.mixedValue);
        io:println("unionType (string|int): ", unionType);
        io:println("nullableUnion (string|null): ", nullableUnion);
        io:println("numericUnion (int|float): ", numericUnion);
        io:println("mixedUnion (boolean|string): ", mixedUnion);
        io:println("  Description: Testing union type configurations\n");
        
        // 3. Enum Configuration
        io:println("--- 3. ENUM CONFIGURATION ---");
        io:println("loggingConfig.level (LogLevel enum): ", loggingConfig.level);
        io:println("loggingConfig.format: ", loggingConfig.format);
        io:println("loggingConfig.maxFiles: ", loggingConfig.maxFiles);
        io:println("  Description: Enum-based configuration (DEBUG, INFO, WARN, ERROR)\n");
        
        // 4. Complex Arrays
        io:println("--- 4. COMPLEX ARRAYS ---");
        io:println("arrayConfig.stringArray: ", arrayConfig.stringArray);
        io:println("  Description: Simple string array");
        io:println("arrayConfig.intArray: ", arrayConfig.intArray);
        io:println("  Description: Simple int array");
        io:println("arrayConfig.floatArray: ", arrayConfig.floatArray);
        io:println("  Description: Simple float array");
        io:println("arrayConfig.booleanArray: ", arrayConfig.booleanArray);
        io:println("  Description: Simple boolean array");
        io:println("arrayConfig.objectArray: ", arrayConfig.objectArray);
        io:println("  Description: Array of DatabaseConfig objects");
        io:println("arrayConfig.mapArray: ", arrayConfig.mapArray);
        io:println("  Description: Array of maps");
        io:println("arrayConfig.nestedStringArray: ", arrayConfig.nestedStringArray);
        io:println("  Description: Nested string array (2D array)");
        io:println("arrayConfig.nestedIntArray: ", arrayConfig.nestedIntArray);
        io:println("  Description: Nested int array (2D array)\n");
        
        // 5. Complex Maps
        io:println("--- 5. COMPLEX MAPS ---");
        io:println("mapConfig.stringMap: ", mapConfig.stringMap);
        io:println("  Description: Map with string values");
        io:println("mapConfig.intMap: ", mapConfig.intMap);
        io:println("  Description: Map with int values");
        io:println("mapConfig.floatMap: ", mapConfig.floatMap);
        io:println("  Description: Map with float values");
        io:println("mapConfig.booleanMap: ", mapConfig.booleanMap);
        io:println("  Description: Map with boolean values");
        io:println("mapConfig.objectMap: ", mapConfig.objectMap);
        io:println("  Description: Map with DatabaseConfig objects as values\n");
        
        io:println("========================================");
        io:println("END OF LEVEL 2 CONFIGURATION TEST");
        io:println("========================================\n");
        
        // Construct greeting message
        string message = "Hello, " + name + "! Level 2 Configuration Test Completed.";
        io:println("Response Message: ", message);
        
        // Return comprehensive Level 2 configuration as JSON
        json response = {
            "greeting": message,
            "level": 2,
            "description": "Nested objects with one level of nesting - Level 2 Configuration Test",
            "configurations": {
                "level2Nested": {
                    "appName": level2Config.appName,
                    "appVersion": level2Config.appVersion,
                    "database": {
                        "host": level2Config.database.host,
                        "port": level2Config.database.port,
                        "username": level2Config.database.username,
                        "password": level2Config.database.password,
                        "sslEnabled": level2Config.database.sslEnabled,
                        "connectionTimeout": level2Config.database.connectionTimeout,
                        "maxPoolSize": level2Config.database.maxPoolSize.toString(),
                        "allowedHosts": level2Config.database.allowedHosts,
                        "ports": level2Config.database.ports
                    },
                    "cache": {
                        "cacheType": level2Config.cache.cacheType,
                        "ttl": level2Config.cache.ttl,
                        "enabled": level2Config.cache.enabled,
                        "memoryLimit": level2Config.cache.memoryLimit,
                        "evictionPolicies": level2Config.cache.evictionPolicies
                    }
                },
                "flexibleConfig": {
                    "flexibleValue": flexibleConfig.flexibleValue.toString(),
                    "nullableString": flexibleConfig?.nullableString,
                    "numericValue": flexibleConfig.numericValue.toString(),
                    "mixedValue": flexibleConfig.mixedValue.toString()
                },
                "loggingConfig": {
                    "level": loggingConfig.level.toString(),
                    "format": loggingConfig.format,
                    "maxFiles": loggingConfig.maxFiles
                },
                "arrayConfig": {
                    "stringArray": arrayConfig.stringArray,
                    "intArray": arrayConfig.intArray,
                    "floatArray": arrayConfig.floatArray,
                    "booleanArray": arrayConfig.booleanArray,
                    "objectArray": arrayConfig.objectArray.toJson(),
                    "mapArray": arrayConfig.mapArray.toJson(),
                    "nestedStringArray": arrayConfig.nestedStringArray,
                    "nestedIntArray": arrayConfig.nestedIntArray
                },
                "mapConfig": {
                    "stringMap": mapConfig.stringMap,
                    "intMap": mapConfig.intMap,
                    "floatMap": mapConfig.floatMap,
                    "booleanMap": mapConfig.booleanMap,
                    "objectMap": mapConfig.objectMap.toJson()
                },
                "unionTypes": {
                    "unionType": unionType.toString(),
                    "nullableUnion": nullableUnion,
                    "numericUnion": numericUnion.toString(),
                    "mixedUnion": mixedUnion.toString()
                }
            },
            "testSummary": {
                "nestingLevel": "1 level deep",
                "requiredConfigsCount": 1,
                "optionalConfigsCount": 7,
                "totalConfigsCount": 8,
                "testedTypes": [
                    "Nested objects (1 level)",
                    "DatabaseConfig (nested object)",
                    "CacheConfig (nested object)",
                    "Union types (string|int, int|float, boolean|string, string|null)",
                    "Enum (LogLevel)",
                    "Arrays of primitives",
                    "Arrays of objects (DatabaseConfig[])",
                    "Arrays of maps (map<string>[])",
                    "Nested arrays (string[][], int[][])",
                    "Maps of primitives",
                    "Maps of objects (map<DatabaseConfig>)",
                    "Optional fields"
                ]
            }
        };
        
        return response;
    }
}