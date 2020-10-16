pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret')
    }
    stages {
        stage('Install dependacies') {
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'cat /etc/*-release'
                    sh 'docker build --tag operacontainer:1.0 .'
                }
            }
        }
        stage('Deploy model on cloud vendor') {
            environment {
                DEPLOY_FILE = 'todolist-dev.csar'
                OPERA_DOCKER_NAME = 'OperaCont'
            }
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {                    
                    sh 'echo Starting container operaContainer...'
                    sh 'mkdir -p $PWD/tmp/radon && cp -r todolist-dev.csar $PWD/tmp/radon'
                    sh 'docker run --name ${OPERA_DOCKER_NAME} --rm -d -p 18080:18080 -v $PWD/tmp/radon:/tmp/radon -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" -e "CTT_FAAS_ENABLED=1" operacontainer:1.0 '
                    sh 'sleep 5'
                    sh 'docker exec ${OPERA_DOCKER_NAME} /bin/bash  && cd tmp/radon && opera init ${DEPLOY_FILE}  && opera deploy'
                }
    
            }
        }
        stage('Test functionality') {
            environment {
                 finish = 'Done!'
            }
            steps {
                sh 'echo Testing functionality...'
                sh 'echo $finish'
            }
        }
    }
    post { 
        always { 
            cleanWs()
        }
    }
}
