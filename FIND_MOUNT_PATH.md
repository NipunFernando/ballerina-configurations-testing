# How to Identify the Correct Mount Path for Config.toml

## Method 1: Check Pod Volume Mounts (Recommended)

```bash
# Get the pod name
POD_NAME=$(kubectl get pods -n <namespace> -l app=make-config-a-secret -o jsonpath='{.items[0].metadata.name}')

# Check volume mounts
kubectl describe pod $POD_NAME -n <namespace> | grep -A 20 "Mounts:"

# Or get JSON output
kubectl get pod $POD_NAME -n <namespace> -o jsonpath='{.spec.containers[*].volumeMounts[*]}' | jq
```

This will show you exactly where Config.toml is being mounted.

## Method 2: Check Working Directory in Container

```bash
# Get pod name
POD_NAME=$(kubectl get pods -n <namespace> -l app=make-config-a-secret -o jsonpath='{.items[0].metadata.name}')

# Check working directory
kubectl exec -n <namespace> $POD_NAME -c <container-name> -- pwd

# List files in common locations
kubectl exec -n <namespace> $POD_NAME -c <container-name> -- ls -la /home/ballerina
kubectl exec -n <namespace> $POD_NAME -c <container-name> -- ls -la /home/ballerina/hello_service

# Find Ballerina.toml location
kubectl exec -n <namespace> $POD_NAME -c <container-name> -- find /home/ballerina -name "Ballerina.toml"

# Check if Config.toml exists in various locations
kubectl exec -n <namespace> $POD_NAME -c <container-name> -- test -f /home/ballerina/Config.toml && echo "Found at /home/ballerina/Config.toml"
kubectl exec -n <namespace> $POD_NAME -c <container-name> -- test -f /home/ballerina/hello_service/Config.toml && echo "Found at /home/ballerina/hello_service/Config.toml"
```

## Method 3: Check Container Environment Variables

```bash
POD_NAME=$(kubectl get pods -n <namespace> -l app=make-config-a-secret -o jsonpath='{.items[0].metadata.name}')

# Check environment variables that might indicate working directory
kubectl exec -n <namespace> $POD_NAME -c <container-name> -- env | grep -i "PWD\|HOME\|WORKDIR"
```

## Method 4: Use Debug Endpoint (After deploying with debug code)

After deploying the service with the debug code added to main.bal:

```bash
# Call the test endpoint
curl http://<service-url>/test

# Check logs
kubectl logs <pod-name> -n <namespace> -c <container-name> | grep "DEBUG INFO"
```

The debug output will show:
- Current working directory
- Whether Config.toml exists at various locations

## Method 5: Check Choreo Build Context

In Choreo, check:
1. Build context path in component settings
2. Dockerfile WORKDIR (if using Docker build)
3. Ballerina build output location

The mountPath should match where Ballerina.toml is located, as Ballerina looks for Config.toml in the same directory.

## Key Rule

**Ballerina looks for Config.toml in the same directory as Ballerina.toml**

So if Ballerina.toml is at: `/home/ballerina/hello_service/Ballerina.toml`
Then Config.toml should be at: `/home/ballerina/hello_service/Config.toml`
Therefore mountPath should be: `/home/ballerina/hello_service`

## Quick Test Commands

```bash
# Replace <namespace> and <pod-name> with actual values
NAMESPACE="dp-development-makeconfigasecret-10730-2875389341"
POD_NAME=$(kubectl get pods -n $NAMESPACE -l app=make-config-a-secret -o jsonpath='{.items[0].metadata.name}' 2>/dev/null)

# Check where Ballerina.toml is
kubectl exec -n $NAMESPACE $POD_NAME -c main-3889905451 -- find / -name "Ballerina.toml" 2>/dev/null

# Check where Config.toml is mounted
kubectl exec -n $NAMESPACE $POD_NAME -c main-3889905451 -- find / -name "Config.toml" 2>/dev/null

# Check volume mounts
kubectl get pod $POD_NAME -n $NAMESPACE -o yaml | grep -A 5 "volumeMounts"
```
