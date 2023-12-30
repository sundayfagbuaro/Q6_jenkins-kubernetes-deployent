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

        stage('Deploy to K8s') {
            steps {
                script {
                    sshagent(['k8']) {
                    sh "scp -o StrictHostKeyChecking=no deployment.yaml bobosunne@192.168.1.91:/home/bobosunne"
                    script{
                        try{
                            sh "ssh bobosunne@192.168.1.91 kubectl apply -f ."
                        }catch(error){
                            sh "ssh bobosunne@192.168.1.91 kubectl create -f ."
                        }
                   }
                }
                }
            }
        }
    }
}

