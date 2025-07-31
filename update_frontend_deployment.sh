#!/bin/bash

YAML_FILE="/Users/ivabar/Workdir/demos/demo-app/02_deployment_app.yaml"

# Check if file exists
if [ ! -f "$YAML_FILE" ]; then
  echo "Error: File $YAML_FILE not found!"
  exit 1
fi

# Change targetPort from 8080 to 8081 in backend-v1 service ONLY
sed -i '' '
  /name: backend-v1$/{
    :loop
    n
    /^  namespace: demo-app$/{
      :loop2
      n
      /targetPort: 8080/{
        s/targetPort: 8080/targetPort: 8081/
        b end
      }
      /type: ClusterIP/!b loop2
    }
    b loop
  }
  :end
' "$YAML_FILE"

# Add env: poc label to frontend-v1 deployment metadata labels
sed -i '' '/name: frontend-v1$/,/^spec:/ s/    version: v1$/    version: v1\n    env: poc/' "$YAML_FILE"

# Add env: poc label to template metadata labels in frontend-v1 deployment
sed -i '' '/name: frontend-v1$/,/        version: v1$/ s/        version: v1$/        version: v1\n        env: poc/' "$YAML_FILE"

echo "Successfully updated $YAML_FILE:"
