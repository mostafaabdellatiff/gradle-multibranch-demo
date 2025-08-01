pipeline {
    agent any

    tools {
        gradle 'gradle'  // This name must match the name you configured in Jenkins → Global Tool Configuration
        // Optionally add: jdk 'jdk-name' if you configured JDK
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub')  // ID of Docker Hub credentials stored in Jenkins
        IMAGE_NAME = "mostafaabdellatif/gradle-project"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Gradle') {
            steps {
                sh './gradlew clean build'
            }
        }

        stage('Test') {
            steps {
                sh './gradlew test'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        def image = docker.build("${IMAGE_NAME}:${env.BRANCH_NAME}")
                        image.push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully for branch ${env.BRANCH_NAME}"
        }
        failure {
            echo "Pipeline failed on branch ${env.BRANCH_NAME}"
        }
    }
}
