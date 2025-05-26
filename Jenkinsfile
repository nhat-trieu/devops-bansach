pipeline {
    agent any

    stages {
        stage('Build & Test') {
            steps {
                sh '''
                    dotnet restore Project_BanSach/Project_BanSach.csproj
                    dotnet build Project_BanSach/Project_BanSach.csproj -c Release
                    dotnet test Project_BanSach/Project_BanSach.csproj --no-build
                '''
            }
        }

        stage('Docker Build') {
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
	stage('Cleanup') {
    		steps {
        sh 'rm -rf Project_BanSach/bin Project_BanSach/obj'
   	 }
	}

    }
}
