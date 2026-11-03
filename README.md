# Ballerina Configuration Testing Service

A comprehensive test suite for validating Ballerina configuration capabilities in WSO2 Choreo across different complexity levels.

## 📋 Overview

This repository contains Ballerina services designed to systematically test configuration schema generation and management in WSO2 Choreo's internal developer platform. The tests are organized into three progressive complexity levels, each validating different aspects of Ballerina's configuration system.

## 🎯 Purpose

The primary goal is to ensure that WSO2 Choreo can properly handle, generate schemas for, and manage Ballerina configurations of varying complexity levels:

- **Level 1**: Simple primitives and basic objects
- **Level 2**: Nested objects with one level of nesting
- **Level 3**: Deeply nested objects with multiple levels (3+)
- **minimal-test**: Minimal config form

## 🌿 Branch Structure

This repository uses a branch-based approach to organize different configuration complexity levels:
```
main
├── required-level-1    → Level 1: Simple Types
├── required-level-2    → Level 2: Nested Objects
└── required-level-3    → Level 3: Deeply Nested Objects
```

### Branch: `main`
- Contains this README and general repository documentation
- Base branch for all configuration testing levels

### Branch: `required-level-1`
**Level 1 - Simple Types (RequiredLevel: 1)**

Tests basic configuration capabilities including:
- ✅ Simple primitives: `string`, `int`, `float`, `decimal`, `boolean`
- ✅ Nullable types: `string?`
- ✅ Union types: `string|int`
- ✅ Simple arrays: `string[]`, `int[]`, `float[]`, `boolean[]`, `decimal[]`
- ✅ Object arrays: `NewGreeting[]`
- ✅ Simple maps: `map<string>`, `map<int>`, `map<float>`, `map<boolean>`, `map<decimal>`
- ✅ Object maps: `map<NewGreeting>`
- ✅ Basic record types: `Greeting`, `NewGreeting`
- ✅ Optional fields within objects
- ✅ Environment variable reading

**Endpoint**: `GET http://localhost:8080/greeting`

**Total Configurations Tested**: 22 configurable variables

### Branch: `required-level-2`
**Level 2 - Nested Objects (RequiredLevel: 2)**

Tests one level of object nesting including:
- ✅ All Level 1 configurations
- ✅ Nested objects (one level deep): `DatabaseConfig`, `CacheConfig` within `Level2Nested`
- ✅ Union types in configurations
- ✅ Enums: `LogLevel` (DEBUG, INFO, WARN, ERROR)
- ✅ Complex arrays: Arrays of objects, arrays of maps, nested arrays
- ✅ Flexible configurations with union types

**Endpoint**: `GET http://localhost:8091/level2?name=<yourname>`

**Key Structure**:
```
Level2Nested (parent)
  ├── DatabaseConfig (child - primitives only)
  ├── CacheConfig (child - primitives only)
  ├── appName (primitive)
  └── appVersion (primitive)
```

### Branch: `required-level-3`
**Level 3 - Deeply Nested Objects (RequiredLevel: 3)**

Tests multiple levels of object nesting (3+ levels deep) including:
- ✅ All Level 1 & 2 configurations
- ✅ Multi-level nesting (3+ levels): `Level3Nested` → `ServiceConfig` → `SecurityConfig` → `AuthProvider`
- ✅ Complex maps with nested object values
- ✅ Advanced combined configurations
- ✅ Comprehensive nested structures

**Endpoint**: `GET http://localhost:8092/level3?name=<yourname>`

**Key Structure**:
```
Level3Nested (Level 1)
  └── ServiceConfig (Level 2)
      └── SecurityConfig (Level 3)
          ├── AuthProvider (oauth) (Level 4)
          │   ├── name, clientId, clientSecret
          │   ├── tokenExpiry, enabled
          │   └── scopes[]
          └── AuthProvider (saml?) (Level 4)
```

## 🚀 Getting Started

### Prerequisites

- Ballerina Swan Lake (2201.13.1 or later)
- macOS, Linux, or Windows environment
- Git

### Installation

1. **Install Ballerina**:
```bash
   # macOS
   brew install ballerina

   # Verify installation
   bal version
```

2. **Clone the repository**:
```bash
   git clone <your-repo-url>
   cd <your-repo-name>
```

## 🧪 Testing Each Level

### Testing Level 1
```bash
# Switch to Level 1 branch
git checkout required-level-1

# Set environment variable
export NAME="YourName"

# Run the service
bal run

# Test the endpoint (in another terminal)
curl http://localhost:8080/greeting
```

**Configuration File**: Create `Config.toml` in the project root with Level 1 configurations (see branch README for details).

### Testing Level 2
```bash
# Switch to Level 2 branch
git checkout required-level-2

# Set environment variable
export NAME="YourName"

# Run the service
bal run

# Test the endpoint
curl "http://localhost:8091/level2?name=YourName"
```

**Configuration File**: Create `Config.toml` with Level 2 nested configurations (see branch README for details).

### Testing Level 3
```bash
# Switch to Level 3 branch
git checkout required-level-3

# Set environment variable
export NAME="YourName"

# Run the service
bal run

# Test the endpoint
curl "http://localhost:8092/level3?name=YourName"
```

**Configuration File**: Create `Config.toml` with Level 3 deeply nested configurations (see branch README for details).

## 📦 Deployment to WSO2 Choreo

### Prerequisites
- WSO2 Choreo account
- Git repository connected to Choreo
- Proper network and registry access configured

### Deployment Steps

1. **Connect Repository to Choreo**:
   - Log in to WSO2 Choreo
   - Create a new component
   - Connect your Git repository

2. **Configure Branch**:
   - Select the branch you want to deploy (`required-level-1`, `required-level-2`, or `required-level-3`)
   - Choreo will detect the Ballerina project automatically

3. **Configure Environment Variables**:
   - In Choreo's configuration management UI, set the `NAME` environment variable
   - Add other required configurations via Choreo's Config.toml editor

4. **Deploy**:
   - Choreo will use the buildpack to compile and deploy your service
   - Monitor the build logs for any issues

5. **Test**:
   - Once deployed, use Choreo's testing interface or external tools to test the endpoints

### Troubleshooting Choreo Deployments

If you encounter module resolution issues (e.g., `cannot resolve module 'ballerina/http'`):

1. **Ensure Dependencies.toml exists**:
```bash
   bal build
   git add Dependencies.toml Ballerina.toml
   git commit -m "Add dependency files"
   git push
```

2. **Check network access**: Ensure Choreo's build environment can access Ballerina Central

3. **Verify buildpack version**: Check that you're using a compatible buildpack version

## 📊 Configuration Coverage

| Level | Primitives | Objects | Arrays | Maps | Nesting | Union Types | Enums | Total Configs |
|-------|-----------|---------|--------|------|---------|-------------|-------|---------------|
| **Level 1** | ✅ All | ✅ Basic | ✅ Simple | ✅ Simple | ❌ None | ✅ Yes | ❌ No | 22 |
| **Level 2** | ✅ All | ✅ Nested (1 level) | ✅ Complex | ✅ Complex | ✅ 1 level | ✅ Yes | ✅ Yes | ~15 |
| **Level 3** | ✅ All | ✅ Deeply Nested | ✅ All types | ✅ All types | ✅ 3+ levels | ✅ Yes | ✅ Yes | ~20 |

## 🔍 What Gets Tested

### Level 1 Tests
- Basic type handling and serialization
- Simple configuration injection
- Environment variable reading
- Default values vs required configurations
- Optional fields and nullable types
- Union type support

### Level 2 Tests
- One-level object composition
- Enum-based configurations
- Complex array structures (nested arrays, object arrays)
- Union types in nested contexts
- Configuration inheritance

### Level 3 Tests
- Deep object nesting (3+ levels)
- Complex map values with nested objects
- Multi-level configuration inheritance
- Advanced type composition
- Comprehensive configuration schemas

## 📝 Response Format

All endpoints return JSON responses with the following structure:
```json
{
  "greeting": "Hello, <name>!",
  "level": <1|2|3>,
  "description": "...",
  "configurations": {
    "primitives": {...},
    "objects": {...},
    "arrays": {...},
    "maps": {...}
  },
  "testSummary": {
    "testedTypes": [...],
    "totalConfigsCount": <number>
  }
}
```

## 🛠️ Project Structure
```
.
├── README.md                 # This file
├── Ballerina.toml           # Package manifest
├── Dependencies.toml        # Dependency lock file
├── Config.toml              # Configuration values
└── main.bal                 # Service implementation
```

## 📚 Additional Resources

- [Ballerina Language Documentation](https://ballerina.io/learn/)
- [WSO2 Choreo Documentation](https://wso2.com/choreo/docs/)
- [Ballerina Configuration Guide](https://ballerina.io/learn/by-example/configurable-variables/)
- [Ballerina HTTP Service Guide](https://ballerina.io/learn/by-example/http-service/)

## 🤝 Contributing

This is a testing repository for WSO2 Choreo configuration validation. If you find issues or want to add more test cases:

1. Create a new branch from the appropriate level branch
2. Add your test cases
3. Submit a pull request with detailed description

## 📄 License

[Specify your license here]

## 👤 Author

**Adeepa Fernando**

## 🔗 Related Projects

- [WSO2 Choreo](https://wso2.com/choreo/)
- [Ballerina Language](https://ballerina.io/)

---

**Note**: This repository is designed for internal testing of WSO2 Choreo's configuration management capabilities. Each branch represents a different complexity level and should be tested independently.