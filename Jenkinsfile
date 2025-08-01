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
        stage('Clean Workspace') {
            steps {
                deleteDir() // This deletes the workspace content
            }
        }
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

        stage('Deploy') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh """
                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                docker build -t mostafaabdellatif/gradle-project:latest .
                docker push mostafaabdellatif/gradle-project:latest
            """
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
