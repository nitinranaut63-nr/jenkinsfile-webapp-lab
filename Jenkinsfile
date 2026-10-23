
pipeline {
    agent any

    options {
        timestamps()
        skipDefaultCheckout(true)
    }

    environment {
        APP_NAME = 'jenkinsfile-webapp-lab'
        PACKAGE_DIR = 'package'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code'
                checkout scm
                sh 'git log -1 --oneline'
            }
        }

        stage('Validate Files') {
            steps {
                sh '''
                    set -eu
                    test -f index.html
                    test -f tests/test-app.sh
                    echo "Required files are present."
                '''
            }
        }

        stage('Test Application') {
            steps {
                sh 'bash tests/test-app.sh'
            }
        }

        stage('Package Application') {
            steps {
                sh '''
                    set -eu
                    rm -rf "$PACKAGE_DIR"
                    mkdir -p "$PACKAGE_DIR/tests"
                    cp index.html "$PACKAGE_DIR/"
                    cp tests/test-app.sh "$PACKAGE_DIR/tests/"
                    tar -czf "${APP_NAME}.tar.gz" -C "$PACKAGE_DIR" .
                    ls -lh "${APP_NAME}.tar.gz"
                '''
            }
        }

        stage('Verify and Archive') {
            steps {
                sh '''
                    set -eu
                    test -s "${APP_NAME}.tar.gz"
                    tar -tzf "${APP_NAME}.tar.gz"
                    echo "Package verification passed."
                '''

                archiveArtifacts(
                    artifacts: 'jenkinsfile-webapp-lab.tar.gz',
                    fingerprint: true
                )
            }
        }
    }

    post {
        success {
            echo 'SUCCESS: Pipeline completed successfully.'
        }

        failure {
            echo 'FAILURE: Check the stage logs.'
        }

        always {
            echo 'Pipeline execution finished.'
        }
    }
}
