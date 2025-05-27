pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
        timeout(time: 10, unit: 'MINUTES')
    }

    stages {
        stage('Docker Build Image') {
            steps {
                sh '''
                    docker build -t webbansach -f Dockerfile .
                '''
            }
        }

        stage('Run App') {
            steps {
                sh '''
                    docker rm -f webbansach || true
                    docker run -d -p 8081:80 --name webbansach webbansach
                '''
            }
        }
    }
}
