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
                sh 'docker build -t sundayfagbuaro/kubetestapp:v1.0 .'
            }
        }

        stage ("Push Docker Image") {
            steps {
                    echo "Pushing the built image to docker hub"
                    withCredentials([string(credentialsId: 'docker-pwd', variable: 'DockerHubPwd')]) {
                sh 'docker login -u sundayfagbuaro -p ${DockerHubPwd}' 
                }
                sh 'docker push sundayfagbuaro/kubetestapp:v1.0'
            }
        }

        stage('List Nodes') {
            steps {
                script {
                        kubernetesDeploy kubeconfigId: 'my_k8_config', secretName: 'K8_Secret_Token_JenkUser', configs: 'deployment.yaml'
                }
            }
                
        }
    }
}

