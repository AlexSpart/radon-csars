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
                echo 'Creating virtual environment'
                sh 'echo Install awscli'
                sh 'pip3 install awscli --user'
                sh 'unzip -o ServerlessToDoListAPI.csar'
                sh 'pip3 install boto3 ansible opera --user'
                sh 'PATH="$(python3 -m site --user-base)/bin:${PATH}" && opera deploy $DEPLOY_FILE'
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
}
