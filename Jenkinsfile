pipeline {
    agent any

    environment {
        GIT_BRANCH = "atlas"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

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

                # Create atlas.sum if missing
                if [ ! -f migrations/atlas.sum ]; then
                    atlas migrate hash --dir "file://migrations"
                fi
                '''
            }
        }

        stage('Generate Migration') {
            steps {
                sh '''
                # Generate migration from schema changes
                atlas migrate diff auto_changes \
                --env local || true

                # Update checksum file
                atlas migrate hash \
                --dir "file://migrations"
                '''
            }
        }

        stage('Commit Migration Files') {
            steps {

                withCredentials([usernamePassword(
                    credentialsId: 'github-creds',
                    usernameVariable: 'GIT_USERNAME',
                    passwordVariable: 'GIT_PASSWORD'
                )]) {

                    sh '''
                    git checkout ${GIT_BRANCH}

                    git config --global user.email "jenkins@local"
                    git config --global user.name "Jenkins"

                    git add migrations/

                    # Commit only if changes exist
                    git diff --cached --quiet || git commit -m "Auto-generated Atlas migration"

                    # Push generated migrations to GitHub
                    git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/AnithaAnnem/Atlas-migration.git ${GIT_BRANCH}
                    '''
                }
            }
        }

        stage('Apply Migration') {
            steps {
                sh '''
                atlas migrate apply \
                --env local 
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
