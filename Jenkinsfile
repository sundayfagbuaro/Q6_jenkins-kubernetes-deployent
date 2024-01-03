pipeline {
    agent{
        label "JENKINS-AGENT-1"
    }
    tools{

    }
    ennvironment{
        APP_NAME = "k8-deployment-test"
        RELEASE = "1.0.0"
        DOCKER_USER = "sundayfagbuaro"
        DOCKER_PASS = "docker-pwd"
        IMAGE_NAME = "${DOCKER_USER}" + "/" "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        JENKINS_API_TOKEN = credentials('JENKINS_API_TOKEN')
    }
    
    stages {
        stage('Cleanup Workspace'){
            steps{
                cleanWs
            }
        }

        stage('SCM Checkout') {
            steps {
                script {
                    git branch: 'ideal',
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
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage ("Push Docker Image") {
            steps {
                    echo "Pushing the built image to docker hub"
                    withCredentials([string(credentialsId: 'docker-pwd', variable: 'DockerHubPwd')]) {
                sh 'docker login -u ${DOCKER_USER} -p ${DockerHubPwd}' 
                }
                sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
            }
        }

    }
}


