pipeline {
    
    environment {
        
        NEW_IMAGE_TAG = getDockerTag()
    }
    
    agent any
    
    
    

    stages {
        
        stage('Git pull') {
            
            steps {
                git branch: 'master', url: 'https://github.com/422divya/3-tier-application.git'
            }
        }
        
        
        stage('build frontend') {
            steps {
                sh 'docker build -t frontend ./frontend'
            }
        }
        
        stage('build backend') {
            steps {
                sh 'docker build -t backend ./backend'
            }
        }
        
        stage ('push image to registry') {
            steps {
                
            
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerregistry')]) {
                    
                    sh 'docker tag frontend divya422/frontend:${NEW_IMAGE_TAG}'
                    sh 'docker tag backend divya422/backend:${NEW_IMAGE_TAG}'
                    
                    sh 'docker login -u divya422 -p $dockerregistry'

                    sh 'docker push divya422/frontend:${NEW_IMAGE_TAG}'
                    sh 'docker push divya422/backend:${NEW_IMAGE_TAG}' 
                    
             }
                
          }
        }
        
        stage ('replace the image tag in docker compose file') {
            steps {
                sh '''
                sed -i 's/IMAGE_TAG/$NEW_IMAGE_TAG/g'  docker-compose.yml

                '''
            }
        }
        
        
        
        stage ('Run docker-compose') {
            steps {
                sh "docker-compose down"
                sh "docker-compose up -d"
            }
        }
        
        
        
    }
}




def getDockerTag() {
            def tag = sh script: 'git rev-parse HEAD', returnStdout: true
            return tag
 }
