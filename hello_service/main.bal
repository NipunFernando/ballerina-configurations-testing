import ballerina/http;
import ballerina/io;
import ballerina/os;

// ============================================
// LEVEL 1 - SIMPLE TYPES (RequiredLevel: 1)
// ============================================

// Basic record types for Level 1
type NewGreeting record {
    string newfrom;
    string newto;
    string newmessage?;
};

type Greeting record {
    string 'from;
    string to;
    string message;
    int age;
    float weight;
    decimal price;
    boolean isActive;
    string[] tags;
    int[] scores;
    float[] measurements;
    NewGreeting[] newGreeting;
    map<NewGreeting> greetingStrMap?;
    map<string> stringMap;
    map<int> intMap;
    map<float> floatMap;
    map<boolean> booleanMap;
};

// Union type for flexible configuration
type ConnectionString string|int;

// ============================================
// LEVEL 1 CONFIGURABLE VARIABLES
// ============================================

// Simple primitive configurables
configurable string? nullString = "abc";
configurable boolean isEnabled = ?;  // Required
configurable int maxRetries = 3;
configurable float timeout = 30.5;
configurable decimal price = 99.99;

// NEW: Additional primitive types not in sample
configurable string simpleString = ?;  // Required - plain string without nullable
configurable int negativeInt = ?;  // Required - to test negative integers
configurable float negativeFloat = -15.5;  // Optional - negative float
configurable decimal largeDecimal = ?;  // Required - large decimal value
configurable boolean falseFlag = false;  // Optional - explicitly false boolean

// Simple object configurable
configurable Greeting nestedGreeting = ?;  // Required

// Simple arrays
configurable string[] tags = ["default"];
configurable int[] numbers = [1, 2, 3];
configurable NewGreeting[] greetingArray = [];

// NEW: Additional array types not in sample
configurable float[] floatArray = ?;  // Required - float array
configurable boolean[] booleanArray = ?;  // Required - boolean array
configurable decimal[] decimalArray = [];  // Optional - decimal array
configurable string[] emptyStringArray = [];  // Optional - empty array test

// Simple maps
configurable map<string> stringMap = {"key1": "value1"};
configurable map<int> intMap = {"key1": 100};
configurable map<NewGreeting> objectMap = {};

// NEW: Additional map types not in sample
configurable map<float> floatMap = ?;  // Required - float map
configurable map<boolean> booleanMap = ?;  // Required - boolean map
configurable map<decimal> decimalMap = {};  // Optional - decimal map
configurable map<string> emptyStringMap = {};  // Optional - empty map test

// NEW: Union type configuration
configurable ConnectionString connectionString = ?;  // Required - union type (string|int)

// Environment variable for the name
configurable string name = os:getEnv("NAME");

// ============================================
// SERVICE
// ============================================

service / on new http:Listener(8080) {
    
    resource function get greeting() returns json {
        // Print all Level 1 configurations with descriptions
        io:println("\n========================================");
        io:println("LEVEL 1 - COMPREHENSIVE CONFIGURATION TEST");
        io:println("========================================\n");
        
        // 1. Simple Primitives - Original
        io:println("--- 1. SIMPLE PRIMITIVES (Original Sample) ---");
        io:println("nullString (string?): ", nullString);
        io:println("  Description: Nullable string type with optional value");
        io:println("isEnabled (boolean): ", isEnabled);
        io:println("  Description: Required boolean flag");
        io:println("maxRetries (int): ", maxRetries);
        io:println("  Description: Integer configuration for retry count");
        io:println("timeout (float): ", timeout);
        io:println("  Description: Float value for timeout duration");
        io:println("price (decimal): ", price);
        io:println("  Description: Decimal type for precise monetary values");
        io:println("name (string from ENV): ", name);
        io:println("  Description: String value from environment variable NAME\n");
        
        // 1b. Simple Primitives - NEW
        io:println("--- 1b. SIMPLE PRIMITIVES (Additional Tests) ---");
        io:println("simpleString (string): ", simpleString);
        io:println("  Description: Plain required string without nullable");
        io:println("negativeInt (int): ", negativeInt);
        io:println("  Description: Testing negative integer values");
        io:println("negativeFloat (float): ", negativeFloat);
        io:println("  Description: Testing negative float values");
        io:println("largeDecimal (decimal): ", largeDecimal);
        io:println("  Description: Testing large decimal precision");
        io:println("falseFlag (boolean): ", falseFlag);
        io:println("  Description: Explicitly false boolean flag");
        io:println("connectionString (string|int union): ", connectionString);
        io:println("  Description: Union type - can be string or int\n");
        
        // 2. Simple Object
        io:println("--- 2. SIMPLE OBJECT (Greeting) ---");
        io:println("nestedGreeting.from: ", nestedGreeting.'from);
        io:println("nestedGreeting.to: ", nestedGreeting.to);
        io:println("nestedGreeting.message: ", nestedGreeting.message);
        io:println("nestedGreeting.age: ", nestedGreeting.age);
        io:println("nestedGreeting.weight: ", nestedGreeting.weight);
        io:println("nestedGreeting.price: ", nestedGreeting.price);
        io:println("nestedGreeting.isActive: ", nestedGreeting.isActive);
        io:println("  Description: Required record type with multiple primitive fields\n");
        
        // 3. Simple Arrays - Original
        io:println("--- 3. SIMPLE ARRAYS (Original Sample) ---");
        io:println("tags (string[]): ", tags);
        io:println("  Description: Array of strings with default");
        io:println("numbers (int[]): ", numbers);
        io:println("  Description: Array of integers with default");
        io:println("greetingArray (NewGreeting[]): ", greetingArray);
        io:println("  Description: Array of objects\n");
        
        // 3b. Simple Arrays - NEW
        io:println("--- 3b. SIMPLE ARRAYS (Additional Tests) ---");
        io:println("floatArray (float[]): ", floatArray);
        io:println("  Description: Required array of floats");
        io:println("booleanArray (boolean[]): ", booleanArray);
        io:println("  Description: Required array of booleans");
        io:println("decimalArray (decimal[]): ", decimalArray);
        io:println("  Description: Array of decimal values");
        io:println("emptyStringArray (string[]): ", emptyStringArray);
        io:println("  Description: Empty array initialization test");
        io:println("nestedGreeting.scores (int[]): ", nestedGreeting.scores);
        io:println("  Description: Integer array inside object");
        io:println("nestedGreeting.measurements (float[]): ", nestedGreeting.measurements);
        io:println("  Description: Float array inside object");
        io:println("nestedGreeting.tags (string[]): ", nestedGreeting.tags);
        io:println("  Description: String array inside object\n");
        
        // 4. Simple Maps - Original
        io:println("--- 4. SIMPLE MAPS (Original Sample) ---");
        io:println("stringMap (map<string>): ", stringMap);
        io:println("  Description: Map with string values and default");
        io:println("intMap (map<int>): ", intMap);
        io:println("  Description: Map with integer values and default");
        io:println("objectMap (map<NewGreeting>): ", objectMap);
        io:println("  Description: Map with object values\n");
        
        // 4b. Simple Maps - NEW
        io:println("--- 4b. SIMPLE MAPS (Additional Tests) ---");
        io:println("floatMap (map<float>): ", floatMap);
        io:println("  Description: Required map with float values");
        io:println("booleanMap (map<boolean>): ", booleanMap);
        io:println("  Description: Required map with boolean values");
        io:println("decimalMap (map<decimal>): ", decimalMap);
        io:println("  Description: Map with decimal values");
        io:println("emptyStringMap (map<string>): ", emptyStringMap);
        io:println("  Description: Empty map initialization test");
        io:println("nestedGreeting.stringMap (map<string>): ", nestedGreeting.stringMap);
        io:println("  Description: Map inside object with string values");
        io:println("nestedGreeting.intMap (map<int>): ", nestedGreeting.intMap);
        io:println("  Description: Map inside object with integer values");
        io:println("nestedGreeting.floatMap (map<float>): ", nestedGreeting.floatMap);
        io:println("  Description: Map inside object with float values");
        io:println("nestedGreeting.booleanMap (map<boolean>): ", nestedGreeting.booleanMap);
        io:println("  Description: Map inside object with boolean values\n");
        
        // 5. Optional Fields
        io:println("--- 5. OPTIONAL FIELDS ---");
        io:println("nestedGreeting.greetingStrMap (map<NewGreeting>?): ", nestedGreeting.greetingStrMap);
        io:println("  Description: Optional map field inside object (can be null)");
        io:println("NewGreeting.newmessage (string?): Testing optional field in NewGreeting type\n");
        
        io:println("========================================");
        io:println("END OF LEVEL 1 CONFIGURATION TEST");
        io:println("========================================\n");
        
        // Construct greeting message
        string message = "Hello, " + name + "!";
        io:println("Response Message: ", message);
        
        // Return comprehensive Level 1 configuration as JSON
        json response = {
            "greeting": message,
            "level": 1,
            "description": "Comprehensive Level 1 Configuration Test - All Simple Types",
            "configurations": {
                "primitives_original": {
                    "nullString": nullString,
                    "isEnabled": isEnabled,
                    "maxRetries": maxRetries,
                    "timeout": timeout,
                    "price": price.toString(),
                    "name": name
                },
                "primitives_additional": {
                    "simpleString": simpleString,
                    "negativeInt": negativeInt,
                    "negativeFloat": negativeFloat,
                    "largeDecimal": largeDecimal.toString(),
                    "falseFlag": falseFlag,
                    "connectionString": connectionString.toString()
                },
                "simpleObject": {
                    "from": nestedGreeting.'from,
                    "to": nestedGreeting.to,
                    "message": nestedGreeting.message,
                    "age": nestedGreeting.age,
                    "weight": nestedGreeting.weight,
                    "price": nestedGreeting.price.toString(),
                    "isActive": nestedGreeting.isActive,
                    "tags": nestedGreeting.tags,
                    "scores": nestedGreeting.scores,
                    "measurements": nestedGreeting.measurements,
                    "newGreeting": nestedGreeting.newGreeting.toJson()
                },
                "arrays_original": {
                    "tags": tags,
                    "numbers": numbers,
                    "greetingArray": greetingArray.toJson()
                },
                "arrays_additional": {
                    "floatArray": floatArray,
                    "booleanArray": booleanArray,
                    "decimalArray": decimalArray.toJson(),
                    "emptyStringArray": emptyStringArray,
                    "nestedGreeting_scores": nestedGreeting.scores,
                    "nestedGreeting_measurements": nestedGreeting.measurements,
                    "nestedGreeting_tags": nestedGreeting.tags
                },
                "maps_original": {
                    "stringMap": stringMap,
                    "intMap": intMap,
                    "objectMap": objectMap.toJson()
                },
                "maps_additional": {
                    "floatMap": floatMap,
                    "booleanMap": booleanMap,
                    "decimalMap": decimalMap.toJson(),
                    "emptyStringMap": emptyStringMap,
                    "nestedGreeting_stringMap": nestedGreeting.stringMap,
                    "nestedGreeting_intMap": nestedGreeting.intMap,
                    "nestedGreeting_floatMap": nestedGreeting.floatMap,
                    "nestedGreeting_booleanMap": nestedGreeting.booleanMap
                },
                "optionalFields": {
                    "nestedGreeting_greetingStrMap": nestedGreeting.greetingStrMap.toJson()
                },
                "unionTypes": {
                    "connectionString": connectionString.toString()
                }
            },
            "testSummary": {
                "originalSampleConfigsCount": 10,
                "additionalConfigsCount": 12,
                "totalConfigsCount": 22,
                "testedTypes": [
                    "string (primitive)",
                    "string? (nullable)",
                    "boolean (primitive)",
                    "int (primitive - positive & negative)",
                    "float (primitive - positive & negative)",
                    "decimal (primitive - small & large)",
                    "string|int (union type)",
                    "string[] (simple array)",
                    "int[] (simple array)",
                    "float[] (simple array)",
                    "boolean[] (simple array)",
                    "decimal[] (simple array)",
                    "NewGreeting[] (object array)",
                    "map<string> (simple map)",
                    "map<int> (simple map)",
                    "map<float> (simple map)",
                    "map<boolean> (simple map)",
                    "map<decimal> (simple map)",
                    "map<NewGreeting> (object map)",
                    "Greeting (simple record/object)",
                    "NewGreeting (simple record/object)",
                    "Optional fields (?)",
                    "Empty arrays/maps initialization"
                ]
            }
        };
        
        return response;
    }
}