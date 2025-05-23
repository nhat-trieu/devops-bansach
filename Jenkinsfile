pipeline {
    agent none

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:6.0'
                }
            }
            steps {
                sh 'dotnet restore Project_BanSach/Project_BanSach.csproj'
                sh 'dotnet build Project_BanSach/Project_BanSach.csproj -c Release'
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:6.0'
                }
            }
            steps {
                sh 'dotnet test Project_BanSach/Project_BanSach.csproj --no-build --verbosity normal'
            }
        }

        stage('Docker Build') {
            agent any
            steps {
                sh 'docker build -t webbansach Project_BanSach'
            }
        }

        stage('Run App') {
            agent any
            steps {
                sh 'docker run -d -p 8081:80 --name webbansach webbansach || true'
            }
        }
    }
}
