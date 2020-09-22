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
                sh 'pip3 install awscli --user'
                sh 'pip3 install boto3 ansible opera --user'
                
                sh 'pip list'

                sh 'unzip -o ServerlessToDoListAPI.csar'
                sh 'opera deploy _definitions/steIgeneral__cloudstash.tosca'

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
