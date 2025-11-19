import ballerina/io;
import ballerina/http;
import ballerina/os;

configurable string name = os:getEnv("NAME");

service / on new http:Listener(8080) {
    
    resource function get greeting() returns string {
        string message = "Hello, " + name + "!";
        io:println(message);
        return message;
    }
}