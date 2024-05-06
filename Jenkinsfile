pipeline {
    agent any

    stages{
        stage('Git Checkout ') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/iam-arellano/activity1'
            }
        }
         stage("Sonarqube Analysis "){
             steps{
                 withSonarQubeEnv('sonarqube_server') {
                     sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=act \
                     -Dsonar.projectKey=act '''
                 }
             }
         }

       stage("Quality Gate"){
           steps {
               script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube_access'
                }	
            }

        }


         stage('Docker Build & Push') {
            steps {
                   script {
                 
                            withDockerRegistry(credentialsId: 'jenkins-docker-credentials') {
                            sh "docker build -t activity1 ."
                            sh "docker tag activity1 raemondarellano/activity1:latest"
                            sh "docker push raemondarellano/activity1:latest "
                        }
                   } 
            }
        }
        

    }
}