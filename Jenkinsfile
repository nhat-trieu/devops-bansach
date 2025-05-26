pipeline {
    agent any

    options {
        // Giữ lại tối đa 3 bản build gần nhất
        buildDiscarder(logRotator(numToKeepStr: '3'))
        // Ngắt nếu build quá 20 phút
        timeout(time: 20, unit: 'MINUTES')
    }

    stages {
        stage('Build & Test (.NET in Docker)') {
            steps {
                sh '''
                    docker run --rm \
                      -v $PWD:/app \
                      -v /var/lib/jenkins/.nuget:/root/.nuget \
                      -w /app \
                      mcr.microsoft.com/dotnet/sdk:6.0 \
                      bash -c "dotnet restore Project_BanSach/Project_BanSach.csproj && \
                               dotnet build Project_BanSach/Project_BanSach.csproj -c Release && \
                               dotnet test Project_BanSach/Project_BanSach.csproj --no-build --verbosity normal"
                '''
            }
        }

        stage('Docker Build Image') {
            steps {
                sh 'docker build -t webbansach Project_BanSach'
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
