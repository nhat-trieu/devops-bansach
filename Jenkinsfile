pipeline {
    agent any

    stages {
        stage('Build in Container') {
            steps {
                sh '''
                    docker run --rm -v $PWD:/app -w /app mcr.microsoft.com/dotnet/sdk:6.0 \
                    bash -c "dotnet restore Project_BanSach/Project_BanSach.csproj && \
                             dotnet build Project_BanSach/Project_BanSach.csproj -c Release && \
                             dotnet test Project_BanSach/Project_BanSach.csproj --no-build --verbosity normal"
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t webbansach Project_BanSach'
            }
        }

        stage('Run App') {
            steps {
                sh 'docker run -d -p 8081:80 --name webbansach webbansach || true'
            }
        }
    }
}
