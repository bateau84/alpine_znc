#!/usr/bin/env groovy
pipeline {
    agent any

    triggers {
        cron('H H 1,15,30 1-11 *')
    }

    environment {
        DOCKER_REGISTRY = 'index.docker.io/'
        DOCKER_REPOSITORY = 'bateau'
        DOCKER_IMAGE_NAME = 'alpine_baseimage'
        DOCKER_ARGS = '--no-cache --squash '
        GIT_COMMIT_ID = sh(returnStdout: true, script: "git rev-parse --short HEAD").trim()
        GIT_BRANCH = sh(returnStdout: true, script: "git rev-parse --abbrev-ref HEAD").replace(" ", "-").replace("/", "-").replace(".", "-")
    }
    
    stages {
        stage('Prepare') {
            steps {
                echo 'Preparing the build environment'
                checkout scm
            }
        }

        stage('Branch Build') {
            when {
                not {
                    branch 'master'
                }
            }
            steps {
                script {
                    def baseimage = docker.build("${env.DOCKER_REGISTRY}${env.DOCKER_REPOSITORY}/${env.DOCKER_IMAGE_NAME}:${env.GIT_BRANCH}-${env.GIT_COMMIT_ID}", "${env.DOCKER_ARGS}.")
                    baseimage.push()
                    env.imageName = baseimage.imageName()
                }
            }
        }

        stage('Master Build') {
            when {
                branch 'master'
            }

            steps {
                script {
                  def baseimage = docker.build("${env.DOCKER_REGISTRY}${env.DOCKER_REPOSITORY}/${env.DOCKER_IMAGE_NAME}:${env.GIT_COMMIT_ID}", "${env.DOCKER_ARGS}.")
                  baseimage.push()
                  baseimage.push("latest")
                }
            }
        }
    }
    post {
        always {
            deleteDir()
        }
    }
}