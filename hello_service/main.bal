import ballerina/io;
import ballerina/http;

// 1. Configurable 'name' with default "World"
configurable string name = "John";

// 2. New configurable 'surname' with default "Doe"
configurable string surname = "Doe";

service / on new http:Listener(8080) {
    
    resource function get greeting() returns string {
        // 3. Updated message to include the surname
        // Using string template for cleaner formatting
        string message = string `Hello, ${name} ${surname}!`;
        
        io:println(message);
        return message;
    }
}