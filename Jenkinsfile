pipeline {
    agent {
        kubernetes {
            yaml """
            apiVersion: v1
            kind: Pod
            metadata:
              labels:
                some-label: jenkins-agent
            spec:
              containers:
              - name: docker
                image: docker:latest
                command: ["cat"]
                tty: true
            """
        }
    }
    stages {
        stage('Build & Push Docker Image') {
            steps {
                container('docker') {
                    sh '''
                    docker build -t boulaz2002/tehcargo-backend:${BUILD_NUMBER} .
                    docker push boulaz2002/tehcargo-backend:${BUILD_NUMBER}
                    '''
                }
            }
        }
    }
}

