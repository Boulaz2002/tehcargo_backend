pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'boulaz2002/tehcargo-backend'
    }

    stages {
        stage('Build & Push Docker Image') {
            steps {
                container('kaniko') {
                    sh '''
                    /kaniko/executor --context=`pwd` \
                      --dockerfile=Dockerfile \
                      --destination=docker.io/${DOCKER_IMAGE}:${BUILD_NUMBER} \
                      --destination=docker.io/${DOCKER_IMAGE}:latest
                    '''
                }
            }
        }
    }
}
