pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:6.0'
                }
            }
            steps {
                sh 'dotnet restore'
                sh 'dotnet build --configuration Release'
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:6.0'
                }
            }
            steps {
                sh 'dotnet test --no-build --verbosity normal'
            }
        }

        stage('Docker Build') {
            agent { label 'docker' } // 👉 Thêm để đảm bảo chạy trên agent có Docker
            steps {
                sh 'docker build -t webbansach Project_BanSach'
            }
        }

        stage('Run App') {
            agent { label 'docker' } // 👉 Thêm để đảm bảo chạy trên host
            steps {
                sh 'docker run -d -p 8081:80 --name webbansach webbansach || true'
            }
        }
    }
}
