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

                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'kubernetes', contextName: '', credentialsId: 'K8_SECRET_TOKEN', namespace: 'default', serverUrl: 'https://192.168.1.91:6443']]) {
                    kubernetesDeploy configs: 'deployment.yaml, service.yaml', kubeconfigId: 'my_k8_config', secretName: 'K8_SECRET_TOKEN'
                    sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.28.4/bin/linux/amd64/kubectl"'
                    sh 'chmod u+x ./kubectl'  
                    sh './kubectl get nodes'
                    sh './kubectl apply -f deployment.yaml'
                    sh './kubectl apply -f service.yaml'
                    sh './kubectl get pods'
                }
            }
        }
    }
}

