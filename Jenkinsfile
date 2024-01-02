pipeline {
    agent any
    
    stages {
        stage('SCM Checkout') {
            steps {
                script {
                    git branch: 'newtest2',
                        credentialsId: 'git-hub', 
                        url: 'https://github.com/sundayfagbuaro/Q6_jenkins-kubernetes-deployent.git'
                // cloning repo
                // git credentialsId: 'git', url: 'https://github.com/sundayfagbuaro/Q3_Jenkins_Pipeline.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building the image"
                sh 'docker build -t sundayfagbuaro/kubetestapp:v1.2 .'
            }
        }

        stage ("Push Docker Image") {
            steps {
                    echo "Pushing the built image to docker hub"
                    withCredentials([string(credentialsId: 'DOCKER-HUB-TOKEN', variable: 'docker-hub-token')]) {
                    sh 'docker login -u sundayfagbuaro -p ${docker-hub-token}' 
                }
                    sh 'docker push sundayfagbuaro/kubetestapp:v1.2'
            }    
        }

        stage('Deploy to K8s') {
            steps {
                script{
                    kubernetesDeploy (configs: "deployment.yaml", kubeconfigId: 'k8config')
                }
            }
        }
    }
}


