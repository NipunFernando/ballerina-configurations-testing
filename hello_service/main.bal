import ballerina/io;
import ballerina/task;
import ballerina/lang.runtime;

// ============================================
// SCHEDULED TASK - SIMPLE CONFIGURATION TEST
// ============================================

// Configurable 1: Environment variable (can be set via Config.toml or env var)
// In Choreo, this can be set as an environment variable MY_ENV_VAR
configurable string envVar = "default_env_value";

// Configurable 2: Secret (REQUIRED - must be provided via Config.toml or Choreo secrets)
configurable string secret = ?;

// Job class that implements the task
class Job {
    *task:Job;
    
    public function execute() {
        io:println("\n========================================");
        io:println("SCHEDULED TASK EXECUTION");
        io:println("========================================");
        io:println("Environment Variable: ", envVar);
        io:println("Secret: ", secret);
        io:println("========================================\n");
    }
}

// Main function to schedule the task
public function main() returns error? {
    // Schedule task to run every 30 seconds
    task:JobId jobId = check task:scheduleJobRecurByFrequency(new Job(), 30);
    io:println("Scheduled task started successfully. Job ID: ", jobId);
    io:println("Task will run every 30 seconds. Press Ctrl+C to stop.");
    
    // Keep the program running
    while true {
        runtime:sleep(1000);
    }
}
