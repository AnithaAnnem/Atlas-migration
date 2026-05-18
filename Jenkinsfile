pipeline {
    agent any

    environment {
        GIT_REPO = "atlas"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Verify Atlas CLI') {
            steps {
                sh '''
                atlas version
                '''
            }
        }

        stage('Generate Migration') {
            steps {
                sh '''
                atlas migrate diff auto_changes \
                --env local
                '''
            }
        }

        stage('Validate Migration') {
            steps {
                sh '''
                atlas migrate lint \
                --env local
                '''
            }
        }

        stage('Commit Migration Files') {
            steps {
                sh '''
                git config --global user.email "jenkins@local"
                git config --global user.name "Jenkins"

                git add migrations/

                git diff --cached --quiet || git commit -m "Auto-generated Atlas migration"

                git push origin ${GIT_REPO}
                '''
            }
        }

        stage('Apply Migration') {
            steps {
                sh '''
                atlas migrate apply \
                --env local \
                --auto-approve
                '''
            }
        }

        stage('Migration Status') {
            steps {
                sh '''
                atlas migrate status \
                --env local
                '''
            }
        }
    }

    post {

        success {
            echo "Atlas migrations completed successfully."
        }

        failure {
            echo "Atlas migration pipeline failed."
        }
    }
}
