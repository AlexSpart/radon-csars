pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret')
    }
    stages {
        stage('Deploy resources') {
            environment {
                DEPLOY_FILE = '_definitions/radonblueprints__ServerlessToDoListAPI.tosca'
            }
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'unzip -o ServerlessToDoListAPI.csar'
                    sh 'pip3 list'
                    sh 'cat /etc/*-release'
                    sh 'pip3 install awscli boto boto3 botocore ansible opera==0.5.9 --user'
                    sh 'PATH=/usr/lib64/python3.6/site-packages:${PATH} && PATH="$(python3 -m site --user-base)/bin:${PATH}" && pip3 list && opera deploy $DEPLOY_FILE'
                }
            }
        }

        stage('Test functionality') {
            environment {
                 BLOB = 'blob'
            }
            steps {
                sh 'echo Testing functionality...'
                sh 'echo BLOB'
            }
        }
    }
    post { 
        always { 
            cleanWs()
        }
    }
}
