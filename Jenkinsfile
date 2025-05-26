pipeline {
    agent any

    environment {
        SONARQUBE_URL = "http://ec2-3-107-91-107.ap-southeast-2.compute.amazonaws.com:9000"
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
        timeout(time: 20, unit: 'MINUTES')
    }

    stages {
        stage('SonarQube Begin') {
            steps {
                withCredentials([string(credentialsId: 'bansach', variable: 'sqp_7f73df179a1cff15bae29385e257728ab3952872')]) {
                    sh '''
                        docker run --rm \
                          -v $PWD:/app \
                          -w /app \
                          mcr.microsoft.com/dotnet/sdk:6.0 \
                          bash -c "dotnet tool install --global dotnet-sonarscanner && \
                                   export PATH=\"$PATH:/root/.dotnet/tools\" && \
                                   dotnet sonarscanner begin /k:'bansach' \
                                   /d:sonar.host.url='$SONARQUBE_URL' \
                                   /d:sonar.login='$SONAR_TOKEN'"
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

        stage('SonarQube End') {
            steps {
                withCredentials([string(credentialsId: 'bansach', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        docker run --rm \
                          -v $PWD:/app \
                          -w /app \
                          mcr.microsoft.com/dotnet/sdk:6.0 \
                          bash -c "export PATH=\"$PATH:/root/.dotnet/tools\" && \
                                   dotnet sonarscanner end /d:sonar.login='$SONAR_TOKEN'"
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
