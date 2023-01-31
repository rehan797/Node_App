pipeline {
    
    agent any

    stages{
        stage ('Git pull') {

            steps{
                git 'git@github.com:rehan797/Node_App.git'

            }
        }    

        stage ('Build Docker image') {
            steps{
                sh "sudo aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 316350455362.dkr.ecr.us-east-1.amazonaws.com"
                sh "sudo docker build -t 316350455362.dkr.ecr.us-east-1.amazonaws.com/node-app:v${BUILD_NUMBER} ."
                sh "sudo docker push 316350455362.dkr.ecr.us-east-1.amazonaws.com/node-app:v${BUILD_NUMBER}"
            }
        }

        stage ('Deploy the image') {
            steps {
                sshagent(['QA_DEPLOY']) {
                
                sh "ssh  -o  StrictHostKeyChecking=no ubuntu@10.0.2.147 sudo docker rm -f node_App"
                sh "ssh ubuntu@10.0.2.147 sudo aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 316350455362.dkr.ecr.us-east-1.amazonaws.com"
                sh "ssh ubuntu@10.0.2.147 docker run  -itd  -p  8080:8081 --name node_App   316350455362.dkr.ecr.us-east-1.amazonaws.com/node-app:v${BUILD_NUMBER}"


                }
            }
        }
    }
}