# Root Cause Analysis: Backend Service Port Mismatch

## Incident Date
July 31, 2025

## Issue
Connection refused error when frontend-v1 tries to reach backend-v1 service.

## Root Cause
The backend-v1 service configuration had a port mismatch. The service definition specified `targetPort: 8081`, but the backend-v1 deployment was actually exposing port 8080. This configuration error prevented the frontend service from establishing connections to the backend.

## Impact
- Frontend application was unable to reach the backend-v1 service
- Users experienced failed requests and application errors
- Functionality requiring backend processing was unavailable

## Resolution
Updated the backend-v1 service definition in kubernetes/backend-v1-service.yaml to use the correct port:
- Changed `targetPort` from 8081 to 8080

## Prevention Measures
1. Implement CI validation checks to verify service and deployment port configurations match
2. Add integration tests that validate service connectivity before deployment
3. Establish documentation for standard port usage across services
4. Consider implementing health check probes to detect connectivity issues early

## Timeline
- Issue detected: July 31, 2025
- Root cause identified: July 31, 2025
- Fix implemented: July 31, 2025