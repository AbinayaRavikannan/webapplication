pipeline {
    environment {
    registry = "aravikan/tomcat"
    registryCredential = 'dockerhub'
    dockerImage = ''
    }
    agent any
    parameters{
       string(name: 'PERSON', defaultValue: 'Abinaya', description: 'Running from my local branch') 
       choice(name: 'Env', choices: ['Dev', 'QA', 'PROD'], description: 'choose your environment')
       gitParameter(branch: '', branchFilter: '.*', defaultValue: 'master', description: 'enter the branch name', name: 'branch', quickFilterEnabled: false, selectedValue: 'NONE', sortMode: 'NONE', tagFilter: '*', type: 'PT_BRANCH')
       booleanParam(name: 'BUILD', defaultValue: true, description: 'Build the code')
    }
    options {
        timeout(time: 2, unit: 'MINUTES') 
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    tools{
        jdk 'java_home'
        maven 'maven_home'
    }
    stages{
        stage('checkout'){
            steps{
                echo "checkout"
                checkout([$class: 'GitSCM', branches: [[name: "${params.branch}"]],
                extensions: [], 
                userRemoteConfigs: [[url: 'https://github.com/AbinayaRavikannan/webapplication.git']]])
        }
        }
        stage('Java Project'){
            parallel {
                stage('test case'){
                    steps{
                       echo "test case skipping"
                       echo "HELLO ${params.PERSON}"
                }
                }
                stage('code quality'){
                    steps{
                       echo "test case skipping"
                }
                }
            }
        }    
        stage('publish report'){
            steps{
                echo "publish report skipping"
        }
        }
        stage('build'){
            when {
                  expression { return params.BUILD }
            }
            steps{
                    echo "build  ${params.BUILD}"
                    sh 'mvn clean install'
        }
        }
        stage('Publish to artifact'){
            steps{
                echo "Publish to artifact"
        }
        }
        stage('Build docker image'){
            steps{
                script {
                  dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
        }
        }
        stage('Deploy Image') {
           steps{
              script {
                  docker.withRegistry( '', registryCredential ) {
                     dockerImage.push()
                  }
              }
           }
        }
        stage('Deploy to k8s') {
           steps{
                sh "chmod +x launch.sh"
                sh "./launch.sh ${BUILD_NUMBER}"
                sshagent(['MINIKUBE']) {
                   sh "scp -o StrictHostKeyChecking=no services.yml myapp-deployment.yml ubuntu@18.221.58.39:/home/ubuntu"
                    script{
                        try{
                            sh "ssh ubuntu@18.221.58.39 kubectl -f apply ."
                        }catch(error){
                            sh "ssh ubuntu@18.221.58.39 kubectl -f create ."
                        }   
                    }    
                }
           }
        }
    } 
    post {
        always {
            cleanWs() /* clean up our workspace */
        }
        success {
            echo 'I succeeded!'
        }
        failure {
            echo 'I failed :('
        }
        changed {
            echo 'Things were different before...'
        }
    }
}
