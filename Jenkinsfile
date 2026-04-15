pipeline {
    agent any

    environment {
        DOCKER_USER = "sudheerttech"
        IMAGE_NAME = "capstone"
    }

    stages {


        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Make Scripts Executable') {
            steps {
                sh 'chmod +x build.sh deploy.sh'
            }
        }

        // ✅ ONE-TIME LOGIN (GLOBAL)
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    '''
                }
            }
        }

        stage('Build Image') {
            steps {
                sh './build.sh'
            }
        }

        // ✅ DEV → push to dev repo
        stage('Push to DEV Repo') {
            when {
                branch 'dev'
            }
            steps {
                sh '''
                docker tag $DOCKER_USER/$IMAGE_NAME:latest $DOCKER_USER/dev:latest
                docker push $DOCKER_USER/dev:latest
                '''
            }
        }

        // ✅ MASTER → push to prod repo
        stage('Push to PROD Repo') {
            when {
                branch 'main'
            }
            steps {
                sh '''
                docker tag $DOCKER_USER/$IMAGE_NAME:latest $DOCKER_USER/prod:latest
                docker push $DOCKER_USER/prod:latest
                '''
            }
        }

        // ✅ Deploy only from PROD
        stage('Deploy (PROD ONLY)') {
            when {
                branch 'main'
            }
            steps {
                sh './deploy.sh'
            }
        }
    }
}
