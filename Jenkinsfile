pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'boulaz2002/tehcargo-backend'
        REGISTRY_CREDENTIALS = 'docker'
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/Boulaz2002/tehcargo_backend.git'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', REGISTRY_CREDENTIALS) {
                        sh """
                        docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} .
                        docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}
                        docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest
                        docker push ${DOCKER_IMAGE}:latest
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                kubectl apply -f k8s/deployment.yaml
                '''
            }
        }
    }
}
