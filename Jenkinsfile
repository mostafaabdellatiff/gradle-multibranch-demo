#!/usr/bin/env groovy

pipeline {
  agent any
  tools { gradle 'gradle' }
  stages {
    stage('Build') {
      steps {
        checkout scm
        sh './gradlew clean build'
      }
    }
    stage('Test') {
      steps {
        sh './gradlew test'
      }
    }
    stage('Deploy') {
      environment {
        IMAGE = "mostafaabdellatif/gradle-demo:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
      }
      steps {
        script {
          docker.withRegistry('', 'docker-hub') {
            def img = docker.build(env.IMAGE)
            img.push()
            img.push('latest')
          }
        }
      }
    }
  }
}