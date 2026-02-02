import ballerina/http;
import ballerina/io;
import ballerina/os;

// ============================================
// MINIMAL TEST - Level 1, 2, 3 Configurations
// ============================================

// Level 1: Simple object
type SimpleConfig record {
    string name;
    int count;
    boolean enabled;
};

// Level 2: One level of nesting
type DatabaseConfig record {
    string host;
    int port;
    boolean sslEnabled;
};

type Level2Config record {
    string appName;
    DatabaseConfig database;
};

// Level 3: Two levels of nesting (3 levels total)
type AuthConfig record {
    string provider;
    string clientId;
    boolean enabled;
};

type SecurityConfig record {
    AuthConfig auth;
    boolean requireHttps;
};

type Level3Config record {
    string serviceName;
    SecurityConfig security;
};

// ============================================
// CONFIGURABLE VARIABLES
// ============================================

// Required configurable strings (3 total, 1 is secret)
configurable string requiredString1 = ?;                    // REQUIRED
configurable string requiredSecretString = ?;                // REQUIRED SECRET (marked as secret in platform)
configurable string requiredString2 = ?;                    // REQUIRED

// Optional configurables (2 total, 1 is secret)
configurable string optionalString = "default_value";       // OPTIONAL
configurable string optionalSecretString = "default_secret"; // OPTIONAL SECRET (marked as secret in platform)

// Required array configurable
configurable string[] requiredStringArray = ?;              // REQUIRED ARRAY

// Optional array configurable
configurable string[] optionalStringArray = ["item1", "item2"]; // OPTIONAL ARRAY

// Environment variable
configurable string name = os:getEnv("NAME");

// ============================================
// SERVICE
// ============================================
service / on new http:Listener(8090) {
    
    resource function get test() returns json {
        io:println("\n========================================");
        io:println("CONFIG WITH SECRETS TEST");
        io:println("========================================\n");
        
        io:println("--- REQUIRED STRINGS ---");
        io:println("requiredString1: ", requiredString1);
        io:println("requiredSecretString: ", requiredSecretString);
        io:println("requiredString2: ", requiredString2);
        io:println("");
        
        io:println("--- OPTIONAL STRINGS ---");
        io:println("optionalString: ", optionalString);
        io:println("optionalSecretString: ", optionalSecretString);
        io:println("");
        
        io:println("--- ARRAYS ---");
        io:println("requiredStringArray: ", requiredStringArray);
        io:println("optionalStringArray: ", optionalStringArray);
        io:println("");
        
        io:println("========================================\n");
        
        string message = "Hello, " + name + "! Config with secrets test completed.";
        
        json response = {
            "greeting": message,
            "test": "make-config-a-secret",
            "configurations": {
                "requiredStrings": {
                    "requiredString1": requiredString1,
                    "requiredSecretString": requiredSecretString,
                    "requiredString2": requiredString2
                },
                "optionalStrings": {
                    "optionalString": optionalString,
                    "optionalSecretString": optionalSecretString
                },
                "arrays": {
                    "requiredStringArray": requiredStringArray,
                    "optionalStringArray": optionalStringArray
                }
            },
            "summary": {
                "totalConfigs": 7,
                "requiredConfigs": 4,
                "optionalConfigs": 3,
                "secrets": {
                    "required": 1,
                    "optional": 1
                },
                "arrays": {
                    "required": 1,
                    "optional": 1
                }
            }
        };
        
        return response;
    }
}