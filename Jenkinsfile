pipeline {
    agent any

    environment {
        GIT_BRANCH = "main"
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

        stage('Initialize Migration Directory') {
            steps {
                sh '''
                mkdir -p migrations

                if [ ! -f migrations/atlas.sum ]; then
                    atlas migrate hash --dir "file://migrations"
                fi
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

                git push origin ${GIT_BRANCH}
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
