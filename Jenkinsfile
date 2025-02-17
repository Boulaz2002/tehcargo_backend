pipeline {
    agent {
        kubernetes {
            yaml """
            apiVersion: v1
            kind: Pod
            metadata:
              name: kaniko
              namespace: jenkins
            spec:
              containers:
              - name: kaniko
                image: gcr.io/kaniko-project/executor:latest
                command:
                - /kaniko/executor
                args:
                - "--dockerfile=Dockerfile"
                - "--context=git://github.com/boulaz2002/tehcargo_backend.git"
                - "--destination=boulaz2002/tehcargo_backend:latest"
                volumeMounts:
                - name: kaniko-secret
                  mountPath: /kaniko/.docker
              restartPolicy: Never
              volumes:
              - name: kaniko-secret
                secret:
                  secretName: dockercred
                  items:
                    - key: .dockerconfigjson
                      path: config.json
            """
        }
    }

    environment {
        DOCKERHUB_USERNAME = "boulaz2002"
        APP_NAME = "tehcargo_backend"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}/${APP_NAME}"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Build and Push Image') {
            steps {
                container('kaniko') {
                    sh """
                    echo "Starting Kaniko build..."
                    /kaniko/executor --dockerfile=Dockerfile \
                    --context=git://github.com/boulaz2002/tehcargo_backend.git \
                    --destination=${IMAGE_NAME}:${IMAGE_TAG}
                    echo "Kaniko build completed."
                    """
                }
            }
        }
    }
}
