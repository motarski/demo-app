# Root Cause Analysis: Backend-v1 Port Mismatch

## Incident Summary
**Date:** July 31, 2025  
**Duration:** [Duration of the incident]  
**Impact:** Connectivity issues between services and backend-v1, resulting in application errors and degraded performance

## Issue Description
A port mismatch was discovered between the backend-v1 Kubernetes Service and Deployment configurations. The Service was configured to target port 8081, while the backend-v1 Deployment was configured to listen on port 8080. This mismatch prevented proper communication between services, causing request failures.

## Timeline
- **[Discovery time]**: Issue first reported through [monitoring alert/user report]
- **[Investigation time]**: Engineering team identified the port mismatch
- **[Resolution time]**: Fix implemented and deployed

## Root Cause
The root cause was identified as a configuration error in the Kubernetes Service definition for backend-v1. The targetPort was incorrectly set to 8081, while the actual container in the Deployment was configured to listen on port 8080.

## Investigation Process
1. Observed error logs showing connection refused errors to backend-v1
2. Verified the backend-v1 pod logs showed the service was listening on port 8080
3. Examined the Service configuration and found the targetPort was set to 8081
4. Confirmed the mismatch between Service and Deployment port configurations

## Resolution
1. Created a fix branch "fix/backend-v1-port-mismatch-20250731"
2. Updated the backend-v1 Service configuration to change targetPort from 8081 to 8080
3. Deployed the change to production
4. Verified connectivity was restored

## Preventive Measures
To prevent similar issues in the future, we recommend:

1. **Configuration Validation**: Implement pre-deployment validation to ensure Service and Deployment port configurations match
2. **Documentation Improvement**: Update documentation to clearly state the expected port configurations
3. **Monitoring Enhancement**: Add specific monitoring for port connectivity between services
4. **CI/CD Pipeline Update**: Add automated tests to verify service connectivity before deployment

## Lessons Learned
1. Configuration alignment between Kubernetes resources is critical
2. Port mismatches can be difficult to identify without proper monitoring
3. Regular configuration audits should be performed as part of maintenance

## Action Items
1. [ ] Implement automated validation for Service and Deployment port consistency
2. [ ] Review all other service configurations to ensure correct port mappings
3. [ ] Update runbooks to include port mismatch as a potential issue to check
4. [ ] Add health checks that specifically verify service connectivity