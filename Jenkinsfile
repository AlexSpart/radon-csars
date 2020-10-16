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
                    sh 'docker ps'
                    sh 'docker build --tag opera-deploy .'
                    sh 'docker stop $(docker ps -aq) || true'
                    sh 'docker ps'
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
                    sh 'docker run --name ${OPERA_DOCKER_NAME} --rm -i -t -p 18080:18080 -v $PWD/tmp/radon:/tmp/radon -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" -e "CTT_FAAS_ENABLED=1" opera-deploy /bin/sh && ls && pip list'
                    sh 'sleep 1'
                    sh 'docker ps'
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
