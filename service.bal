import ballerina/http;

// Required configs — no defaults (Choreo must supply these)
configurable string requiredConfig = ?;
configurable string requiredSecret = ?;

// Optional configs — have defaults, Choreo can override
configurable string optionalConfig = "default-config-value";
configurable string optionalSecret = "default-secret-value";

// ── Endpoint 1 — port 8080 ──────────────────────────────────────────────────
service /ep1 on new http:Listener(8080) {
    resource function get info() returns json {
        return {
            "endpoint": "ep1",
            "port": 8080,
            "requiredConfig": requiredConfig,
            "requiredSecret": requiredSecret,
            "optionalConfig": optionalConfig,
            "optionalSecret": optionalSecret
        };
    }
}

// ── Endpoint 2 — port 9090 ─────────────────   "endpoint": "ep2",
            "port": 9090,
            "requiredConfig": requiredConfig,
            "requiredSecret": requiredSecret,
            "optionalConfig": optionalConfig,
            "optionalSecret": optionalSecret
        };
    }
}
