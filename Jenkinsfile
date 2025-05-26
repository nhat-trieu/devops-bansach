pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
        timeout(time: 20, unit: 'MINUTES')
    }

    stages {
        stage('SonarCloud Begin') {
            steps {
                withCredentials([string(credentialsId: 'sonarcloud-token', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        docker run --rm \
                          -v $PWD:/app \
                          -w /app \
                          mcr.microsoft.com/dotnet/sdk:6.0 \
                          bash -c "dotnet tool install --global dotnet-sonarscanner && \
                                   export PATH=\\\"$PATH:/root/.dotnet/tools\\\" && \
                                   dotnet sonarscanner begin /k:'nhat-trieu_devops-bansach' \
                                   /o:'nhat-trieu' \
                                   /d:sonar.host.url='https://sonarcloud.io' \
                                   /d:sonar.login=$SONAR_TOKEN"
                    '''
                }
            }
        }

        stage('Build & Test') {
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

        stage('SonarCloud End') {
            steps {
                withCredentials([string(credentialsId: 'sonarcloud-token', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        docker run --rm \
                          -v $PWD:/app \
                          -w /app \
                          mcr.microsoft.com/dotnet/sdk:6.0 \
                          bash -c "export PATH=\\\"$PATH:/root/.dotnet/tools\\\" && \
                                   dotnet sonarscanner end /d:sonar.login=$SONAR_TOKEN"
                    '''
                }
            }
        }

        stage('Docker Build Image') {
            steps {
                sh 'docker build -t webbansach -f Dockerfile .'
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
