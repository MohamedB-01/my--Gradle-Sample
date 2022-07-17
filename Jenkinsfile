pipeline{
    agent any
    tools {
        jdk 'JDK11'
    }
    stages {
        stage('clone repo'){
            steps {
                git 'https://github.com/MohamedB-01/my--Gradle-Sample'
            }
    }
     stage('SonarQube analysis') {
         steps{
             script{
                       def scannerHome = tool 'sonarQube';

                       withSonarQubeEnv('sonarCloud') { // Will pick the global server connection you have configured
                       bat "${scannerHome}/bin/sonar-scanner"
                    }
             }
         }
     }


        stage ('Build project'){
            steps {
                bat 'gradle clean build'
            }

        }

         stage('Build docker image'){
            steps {
                script {
                    dockerImage = docker.build("mbdocker001/coglab:${env.BUILD_NUMBER}")
                }

            }
        }

         stage('Build docker deploy'){
            steps {
                script {
                     def dockerImageTag= "mbdocker001/project1:${env.BUILD_NUMBER}"
                     echo "Docker Image Tag name : ${dockerImageTag}"
                     docker.withRegistry('https://registry.hub.docker.com','docker_hub_credentials'){
                         dockerImage.push("${env.BUILD_NUMBER}")
                         dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes'){
            steps {
                kubernetesDeploy(configs: "kubernetes.yml", kubeconfigId: "kubernetes", enableConfigSubstitution: true)
            }
        }
    }
}
