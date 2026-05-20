import ballerina/http;
import ballerina/io;

// Scenario 1: All optional fields, no defaults
// Optional field with '?' means the field can be absent (presence-optional)
type StrictlyOptionalConfig record {|
    string host?;
    int port?;
|};

// Scenario 2: All optional fields, all have defaults
// Fields are not presence-optional — they always exist, but have fallback values
type DefaultedConfig record {|
    string host = "localhost";
    int port = 8080;
|};

// Scenario 3: Mix of required and optional fields, no defaults for optional
// 'apiSecret' must always be present; 'host' and 'port' can be absent
type MixedConfig record {|
    string apiSecret;
    string host?;
    int port?;
|};

// Scenario 4: Mix of required and optional fields, optional has a default
// 'apiSecret' must always be present; 'port' defaults to 8080 if not provided
type MixedConfigWithDefaults record {|
    string apiSecret;
    int port = 8080;
|};

// Scenario 1: configurable var has a default (empty record) — so the var itself is optional in Config.toml
configurable StrictlyOptionalConfig strictlyOptional = {};

// Scenario 2: configurable var has a default (empty record, fields fall back to their declared defaults)
configurable DefaultedConfig withDefaults = {};

// Scenario 3: configurable var is REQUIRED (= ?) — but its record fields include optional ones
// The ambiguity: must 'host?' and 'port?' still appear in Config.toml?
configurable MixedConfig mixed = ?;

// Scenario 4: configurable var is REQUIRED (= ?) — but 'port' has a record-level default
// The ambiguity: does Ballerina honor 'port = 8080' or require it in Config.toml?
configurable MixedConfigWithDefaults mixedWithDefaults = ?;

service / on new http:Listener(8080) {
    resource function get configs() returns string {
        string result = string `Scenario 1 (StrictlyOptional - all optional, no defaults):
  host = ${strictlyOptional.host ?: "(absent)"}
  port = ${(strictlyOptional.port ?: 0).toString()}

Scenario 2 (DefaultedConfig - all optional, with defaults):
  host = ${withDefaults.host}
  port = ${withDefaults.port}

Scenario 3 (MixedConfig - required + optional, no defaults for optional):
  apiSecret = ${mixed.apiSecret}
  host = ${mixed.host ?: "(absent)"}
  port = ${(mixed.port ?: 0).toString()}

Scenario 4 (MixedConfigWithDefaults - required + optional with default):
  apiSecret = ${mixedWithDefaults.apiSecret}
  port = ${mixedWithDefaults.port}
`;
        io:println(result);
        return result;
    }
}
