#!/usr/bin/env groovy

podTemplate(label: 'jenkins-slave', containers: [
    //containerTemplate(name: 'jnlp', image: 'jenkins/jnlp-slave:latest-jdk11',
    containerTemplate(name: 'jnlp', image: 'lsegal/jnlp-docker-agent:alpine',
                        args: '${computer.jnlpmac} ${computer.name}', workingDir: '/home/jenkins',
                        resourceRequestCpu: '200m', resourceLimitCpu: '300m',
                        resourceRequestMemory: '256Mi', resourceLimitMemory: '512Mi'),
    containerTemplate(name: 'nodejs', image: 'node:8.15-slim', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'docker', image: 'docker:dind', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'helm', image: 'alpine/helm:2.12.3', command: 'cat', ttyEnabled: true)
],
volumes:[
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
]) {

  ansiColor('xterm') {
    node ('jenkins-slave') {

        //currentBuild.displayName = env.BUILD_ID
        currentBuild.description = WORKSPACE.split('/')[-1].replace('_', '-').toLowerCase()

        stage('Checkout') {
            deleteDir()
            checkout scm
            sh "env"
        }

        /*
        stage('Package') {
            container('nodejs') {
                sh "npm install"
            }
        }
        */

        stage('Container') {
            //container('docker') {
                sh "docker build -t hello-pod:latest -f Dockerfile ."
            //}
        }

        stage('Deploy') {
            container('helm') {
                sh "helm version"
                sh "helm list"
            }
        }
        
    }
  }
}
