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
                    sh 'docker stop RadonVT || true'
                }
            }
        }
        stage('Run VT') {
            environment {
                DEPLOY_FILE = 'ServerlessToDoListAPI.csar'
                VT_DOCKER_NAME = 'RadonVT'
                VT_FILES_PATH = '{"path":"/tmp/radon/main.cdl"}'
            }
            steps {
                sh 'echo Deploy topology usinh orchestrator opera...'
                sh 'unzip -o &{DEPLOY_FILE}'
                sh 'mkdir -p $PWD/tmp/radon && cp -r _definitions $PWD/tmp/radon/_definitions && cp main.cdl $PWD/tmp/radon'
                sh 'docker run --name "${VT_DOCKER_NAME}" --rm -d -p 5000:5000 -v $PWD/tmp/radon:/tmp/radon marklawimperial/verification-tool'
                sh 'sleep 5'
                sh 'docker exec RadonVT /bin/bash  && cd tmp/radon && ls -al && cat main.cdl'
                sh 'docker ps && curl -X POST -H "Content-type: application/json" http://localhost:5000/solve/ -d ${VT_FILES_PATH}'
                sh 'docker stop &{VT_DOCKER_NAME}'
            }
        }
        stage('Opera Deploy') {
            environment {
                DEPLOY_FILE = 'todolist-dev.csar'
                OPERA_DOCKER_NAME = 'prqCont'
            }
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {  
                    sh 'echo Creating image opera-deploy...'
                    sh 'docker build --tag opera-deploy .'
                    sh 'echo Starting container prqCont...'
                    sh 'mkdir -p $PWD/tmp/radon && cp -r todolist-dev.csar $PWD/tmp/radon'
                    sh 'docker run --name ${OPERA_DOCKER_NAME} --rm -d -p 18080:18080 -v $PWD/tmp/radon:/tmp/radon/container -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" -e "CTT_FAAS_ENABLED=1" opera-deploy'
                    sh 'sleep 5'
                    sh 'docker exec ${OPERA_DOCKER_NAME} sh -c "cd /tmp/radon/container && opera init todolist-dev.csar && opera deploy "'
                    sh 'docker stop $OPERA_DOCKER_NAME'
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

