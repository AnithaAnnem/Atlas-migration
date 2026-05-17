pipeline {
    agent any

    environment {
        DB_URL = "postgres://postgres:postgres@localhost:5432/testdb?sslmode=disable"
        MIGRATIONS_DIR = "file://migrations"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Checking out repository..."
                checkout scm
            }
        }

        stage('Setup Atlas') {
            steps {
                echo "Installing/Verifying Atlas CLI..."
                sh '''
                    curl -sSf https://atlasgo.sh | sh
                    atlas version
                '''
            }
        }

        stage('Validate Migrations') {
            steps {
                echo "Validating migration files..."
                sh '''
                    atlas migrate lint \
                    --dir ${MIGRATIONS_DIR}
                '''
            }
        }

        stage('Apply Migrations') {
            steps {
                echo "Applying database migrations..."
                sh '''
                    atlas migrate apply \
                    --dir ${MIGRATIONS_DIR} \
                    --url ${DB_URL}
                '''
            }
        }

        stage('Verify DB State') {
            steps {
                echo "Verifying applied migrations..."
                sh '''
                    atlas migrate status \
                    --dir ${MIGRATIONS_DIR} \
                    --url ${DB_URL}
                '''
            }
        }
    }

    post {
        success {
            echo "Database migrations applied successfully."
        }

        failure {
            echo "Migration failed. Check logs."
        }
    }
}
