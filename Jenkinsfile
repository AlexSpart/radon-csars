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
                    sh 'echo install any dependancies..'
                }
            }
        }
        stage('Run DPT') {
            environment {
                DEPLOY_FILE = 'todolist-dev.csar'
                DPT_DOCKER_NAME = 'RadonDPT'
            }
            steps {
                sh 'echo Start DPT container and perform test...'
                sh 'mkdir -p $PWD/radon-dpt && cp -r todolist-dev.csar $PWD/radon-dpt'
        
                sh 'git clone https://github.com/radon-h2020/radon-defect-prediction-cli.git'
                sh 'cd radon-defect-prediction-cli && pip3 install -r requirements.txt --user && pip3 install .  --user'
                sh 'pip3 list'
                sh 'cd $PWD/radon-dpt && PATH="$(python3 -m site --user-base)/bin:${PATH}" && radon-defect-predictor download-model tosca github AlexSpart/radon-csars && radon-defect-predictor predict tosca $DEPLOY_FILE '
                sh 'pwd && ls -l'
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

