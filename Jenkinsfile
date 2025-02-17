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

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/boulaz2002/tehcargo_backend.git'
            }
        }

        stage('Build and Push Image') {
            steps {
                script {
                    sh """
                    echo "Kaniko build started..."
                    kubectl delete pod kaniko -n jenkins || true
                    kubectl apply -f kaniko.yaml
                    kubectl wait --for=condition=complete pod/kaniko -n jenkins --timeout=300s
                    """
                }
            }
        }
    }
}
