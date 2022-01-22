pipeline {
    agent any 
    stages {
        stage('checkout') { 
            steps {
                bat 'echo saredo'
                git branch: 'main', 
                credentialsId: 'ce8bfe48-614f-4702-a782-5bad67094d44', url: 'git@github.com:rohitagarwal210895/terraform_demo.git'
            }
        }
        stage('terraform initialization') { 
            steps {
                bat 'echo ehis'
               // terraform init
            }
        }
        stage('plan') { 
            steps {
                 bat 'echo sophie'
                // terraform plan
            }
        }
        stage('apply') { 
            steps {
                 bat 'echo sophie'
                 //erraform apply -auto-approve
            }
        }
        
    }
}
