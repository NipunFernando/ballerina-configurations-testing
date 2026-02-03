import ballerina/http;
import ballerina/io;
import ballerina/os;
import ballerina/file;

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

// Helper function to check if file exists
function checkFileExists(string path) returns string {
    var result = file:exists(path);
    if result is boolean {
        return result.toString();
    } else {
        return "error: " + result.toString();
    }
}

// ============================================
// SERVICE
// ============================================
service / on new http:Listener(8090) {
    
    resource function get test() returns json {
        io:println("\n========================================");
        io:println("CONFIG WITH SECRETS TEST");
        io:println("========================================\n");
        
        // Debug: Print working directory and file locations
        io:println("--- DEBUG INFO ---");
        io:println("Current working directory: ", os:getEnv("PWD") ?: "unknown");
        io:println("Checking for Config.toml locations:");
        io:println("  /home/ballerina/Config.toml exists: ", checkFileExists("/home/ballerina/Config.toml"));
        io:println("  /home/ballerina/hello_service/Config.toml exists: ", checkFileExists("/home/ballerina/hello_service/Config.toml"));
        io:println("  ./Config.toml exists: ", checkFileExists("./Config.toml"));
        io:println("");
        
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