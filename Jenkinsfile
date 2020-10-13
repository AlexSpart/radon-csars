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
                    sh 'echo $PWD'
                    sh 'pip3 install awscli boto boto3 botocore ansible opera docker --user'
                }
            }
        }
        stage('Run VT') {
            environment {
                DEPLOY_FILE = 'ServerlessToDoListAPI.csar'
            }
            steps {
                sh 'echo Deploy topology usinh orchestrator opera...'
                sh 'unzip -o ServerlessToDoListAPI.csar'
                sh 'mkdir -p $PWD/tmp/radon && cp -r _definitions $PWD/tmp/radon/_definitions && cp main.cdl $PWD/tmp/radon'
                sh 'ls $PWD/tmp/radon && ls $PWD/tmp/radon/_definitions'
                sh 'docker run --rm -p 5000:5000 -v /tmp/radon:/tmp/radon marklawimperial/verification-tool'
                sh ' curl -X POST -H "Content-type: application/json" http://localhost:5000/solve/ -d '{"path":"/tmp/radon/main.cdl"}' '
            }
        }
        stage('Deploy model on cloud vendor') {
            environment {
                DEPLOY_FILE = 'ServerlessToDoListAPI.csar'
            }
            steps {
                sh 'echo Deploy topology using orchestrator opera...'
                sh 'PATH="$(python3 -m site --user-base)/bin:${PATH}" && opera init $DEPLOY_FILE && opera deploy'
                
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
