pipeline {
    agent any
    
    stages {
        stage('SCM Checkout') {
            steps {
                script {
                    git branch: 'testbranch',
                        credentialsId: 'git', 
                        url: 'https://github.com/sundayfagbuaro/Q3_Jenkins_Pipeline.git'
                // cloning repo
                // git credentialsId: 'git', url: 'https://github.com/sundayfagbuaro/Q3_Jenkins_Pipeline.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building the image"
                sh 'docker build -t sundayfagbuaro/jenkdockapp:v3.2 .'
            }
        }

        stage ("Push Docker Image") {
            steps {
                    echo "Pushing the built image to docker hub"
                    withCredentials([string(credentialsId: 'docker-pwd', variable: 'DockerHubPwd')]) {
                sh 'docker login -u sundayfagbuaro -p ${DockerHubPwd}' 
                }
                sh 'docker push sundayfagbuaro/jenkdockapp:v3.2'
            }
        }

        stage('Run Container on The Dev Server') {
            steps {
                script {
                    sshagent(['dev_server']) {
                        sh """ssh -tt -o StrictHostKeyChecking=no bobosunne@192.168.1.85 << EOF
                        docker stop jenkdockapp
                        docker rm jenkdockapp
                        docker run -d -p 8080:80 --name jenkdockapp sundayfagbuaro/jenkdockapp:v3.2
                        exit
                        EOF"""
                    }
                }
            }
        }
    }
}