pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret')
    }
    stages {
        stage('Deploy resources') {
            environment {
                DEPLOY_FILE = 'ServerlessToDoListAPI.csar'
            }
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'cat /etc/*-release'
                    sh 'pip3 install awscli boto boto3 botocore ansible opera docker--user'
                    sh 'unzip -o ServerlessToDoListAPI.csar'
                    sh 'mkdir /tmp/radon && cp _definitions /tmp/radon && cp main.cdl /tmp/radon'
                    sh 'docker run -p 5000:5000 -v /tmp/radon:/tmp/radon marklawimperial/verification-tool'
                    sh ' curl -X POST -H "Content-type: application/json" http://localhost:5000/solve/ -d '{"path":"/tmp/radon/main.cdl"}' '
                    sh 'PATH="$(python3 -m site --user-base)/bin:${PATH}" && opera init $DEPLOY_FILE && opera deploy'
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
