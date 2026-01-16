import ballerina/http;
import ballerina/io;

// ============================================
// SHORT LEVEL 3 - COMPLEX CONFIGURABLES
// ============================================

// Complex nested object type for maps
type DatabaseConnection record {
    string host;
    int port;
    string database;
    boolean sslEnabled;
    string[] allowedIPs;
};

// Complex nested object type for arrays
type ServiceEndpoint record {
    string url;
    int timeout;
    map<string> headers;
    boolean enabled;
};

// Complex type: Map of objects with nested arrays
type DatabaseConfig record {
    map<DatabaseConnection> connections;
    string[] primaryHosts;
    map<string[]> connectionPools;
};

// Complex type: Array of maps with nested objects
type ServiceConfig record {
    ServiceEndpoint[] endpoints;
    map<ServiceEndpoint> endpointMap;
    map<string[]> routeGroups;
};

// ============================================
// CONFIGURABLE VARIABLES
// ============================================

// 1. Complex configurable WITHOUT default (REQUIRED) - Map of objects with nested arrays
configurable DatabaseConfig dbConfig = ?;

// 2. Complex configurable WITHOUT default (REQUIRED) - Array of maps with nested objects
configurable ServiceConfig serviceConfig = ?;

// 3. Complex configurable WITH default - Map of objects with nested arrays
configurable DatabaseConfig dbConfigWithDefaults = {
    connections: {
        "primary": {
            host: "localhost",
            port: 5432,
            database: "default_db",
            sslEnabled: false,
            allowedIPs: ["127.0.0.1"]
        }
    },
    primaryHosts: ["localhost"],
    connectionPools: {
        "pool1": ["host1", "host2"]
    }
};

// 4. Complex configurable WITH default - Array of maps with nested objects
configurable ServiceConfig serviceConfigWithDefaults = {
    endpoints: [
        {
            url: "http://localhost:8080",
            timeout: 30,
            headers: {"Content-Type": "application/json"},
            enabled: true
        }
    ],
    endpointMap: {
        "api": {
            url: "http://localhost:8080/api",
            timeout: 30,
            headers: {"Authorization": "Bearer token"},
            enabled: true
        }
    },
    routeGroups: {
        "public": ["/health", "/status"],
        "private": ["/admin", "/users"]
    }
};

// 5. Secret WITHOUT default (REQUIRED)
configurable string apiSecret = ?;

// 6. Secret WITH default
configurable string defaultSecret = "default_secret_key_12345";

// ============================================
// SERVICE
// ============================================
service / on new http:Listener(8092) {
    
    resource function get level3() returns json {
        io:println("\n========================================");
        io:println("SHORT LEVEL 3 - COMPLEX CONFIGURABLES TEST");
        io:println("========================================\n");
        
        // 1. Required Database Config (Map of objects with nested arrays)
        io:println("--- 1. REQUIRED DATABASE CONFIG (Map<DatabaseConnection>) ---");
        io:println("dbConfig.primaryHosts: ", dbConfig.primaryHosts);
        if dbConfig.connections.length() > 0 {
            foreach string key in dbConfig.connections.keys() {
                readonly & DatabaseConnection? conn = dbConfig.connections[key];
                if conn is readonly & DatabaseConnection {
                    io:println("  Connection [", key, "]: ", conn.host, ":", conn.port);
                    io:println("    Allowed IPs: ", conn.allowedIPs);
                }
            }
        }
        io:println("  Description: Complex map of objects with nested arrays\n");
        
        // 2. Required Service Config (Array of maps with nested objects)
        io:println("--- 2. REQUIRED SERVICE CONFIG (ServiceEndpoint[] + map<ServiceEndpoint>) ---");
        io:println("serviceConfig.endpoints count: ", serviceConfig.endpoints.length());
        foreach ServiceEndpoint endpoint in serviceConfig.endpoints {
            io:println("  Endpoint: ", endpoint.url, " (timeout: ", endpoint.timeout, ")");
        }
        if serviceConfig.endpointMap.length() > 0 {
            foreach string key in serviceConfig.endpointMap.keys() {
                readonly & ServiceEndpoint? ep = serviceConfig.endpointMap[key];
                if ep is readonly & ServiceEndpoint {
                    io:println("  EndpointMap [", key, "]: ", ep.url);
                }
            }
        }
        io:println("  Description: Complex array of objects + map of objects\n");
        
        // 3. Database Config with Defaults
        io:println("--- 3. DATABASE CONFIG WITH DEFAULTS ---");
        io:println("dbConfigWithDefaults.primaryHosts: ", dbConfigWithDefaults.primaryHosts);
        io:println("  Description: Map of objects with default values\n");
        
        // 4. Service Config with Defaults
        io:println("--- 4. SERVICE CONFIG WITH DEFAULTS ---");
        io:println("serviceConfigWithDefaults.endpoints count: ", serviceConfigWithDefaults.endpoints.length());
        io:println("  Description: Array of maps with default values\n");
        
        // 5. Required Secret
        io:println("--- 5. REQUIRED SECRET (NO DEFAULT) ---");
        io:println("apiSecret: ", apiSecret);
        io:println("  Description: Required secret without default\n");
        
        // 6. Secret with Default
        io:println("--- 6. SECRET WITH DEFAULT ---");
        io:println("defaultSecret: ", defaultSecret);
        io:println("  Description: Secret with default value\n");
        
        io:println("========================================");
        io:println("END OF SHORT LEVEL 3 CONFIGURATION TEST");
        io:println("========================================\n");
        
        // Return comprehensive configuration as JSON
        json response = {
            "greeting": "Short Level 3 Complex Configurables Test Completed",
            "level": 3,
            "description": "Short version with 2 required complex configurables, 2 complex configurables with defaults, 1 required secret, and 1 secret with default",
            "configurations": {
                "requiredComplexConfigs": {
                    "dbConfig": {
                        "primaryHosts": dbConfig.primaryHosts,
                        "connectionsCount": dbConfig.connections.length(),
                        "connectionPoolsCount": dbConfig.connectionPools.length()
                    },
                    "serviceConfig": {
                        "endpointsCount": serviceConfig.endpoints.length(),
                        "endpointMapCount": serviceConfig.endpointMap.length(),
                        "routeGroupsCount": serviceConfig.routeGroups.length()
                    }
                },
                "complexConfigsWithDefaults": {
                    "dbConfigWithDefaults": {
                        "primaryHosts": dbConfigWithDefaults.primaryHosts,
                        "connectionsCount": dbConfigWithDefaults.connections.length()
                    },
                    "serviceConfigWithDefaults": {
                        "endpointsCount": serviceConfigWithDefaults.endpoints.length(),
                        "endpointMapCount": serviceConfigWithDefaults.endpointMap.length()
                    }
                },
                "secrets": {
                    "apiSecret": apiSecret,
                    "defaultSecret": defaultSecret
                }
            },
            "testSummary": {
                "requiredComplexConfigs": 2,
                "complexConfigsWithDefaults": 2,
                "requiredSecrets": 1,
                "secretsWithDefaults": 1,
                "totalConfigs": 6,
                "complexTypes": [
                    "Map of objects with nested arrays (map<DatabaseConnection>)",
                    "Array of objects + Map of objects (ServiceEndpoint[] + map<ServiceEndpoint>)",
                    "Map with array values (map<string[]>)",
                    "Nested records with arrays and maps"
                ]
            }
        };
        
        return response;
    }
}
