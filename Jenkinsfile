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
                sh 'python3 -m venv .venv && . .venv/bin/activate && pip install boto3 botocore ansible opera --user && pip list'
                sh 'pip list'
                sh 'unzip -o cloudstash.csar'
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
