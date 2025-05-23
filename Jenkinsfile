pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/dotnet/sdk:6.0'
        }
    }

    stages {
        stage('Build') {
            steps {
                sh 'dotnet restore'
                sh 'dotnet build --configuration Release'
            }
        }

        stage('Test') {
            steps {
                sh 'dotnet test --no-build --verbosity normal'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t webbansach .'
            }
        }

        stage('Run App') {
            steps {
                sh 'docker run -d -p 8081:80 --name webbansach webbansach || true'
            }
        }
    }
}
