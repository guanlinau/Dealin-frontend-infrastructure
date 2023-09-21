#!/user/bin/env/groovy
def gv
pipeline{
    agent any

    parameters {
        booleanParam(name:'CreateResources', defaultValue:false, description: 'Select when you want to create resources to uat, such as eks, vpc, subnets, nat gateway, nodegroup, etc.')
        booleanParam(name:'DestroyResources', defaultValue:false, description: 'Select when you want to destroy resources from uat!')
        booleanParam(name:'CreateResources_to_Production', defaultValue:false, description: 'Select when you want to create resources to production, such as eks, vpc, subnets, nat gateway, nodegroup, etc.')
        booleanParam(name:'DestroyResources_from_Production', defaultValue:false, description: 'Select when you want to destroy resources from production!')
    }
	environment {
		AWS_CREDENTIALS = "aws_credentials"
        AWS_REGION = "ap-southeast-2"
        APPLY = "apply"
        DESTROY = "destroy"
        MAXATTEMPTS= 2
	}
    
    stages{
        stage ("Init load groovy") {
            steps{
                ansiColor('vga'){
                    script{
                        gv=load "script.groovy"
                    }
                    
                }
            }
        }
        stage("Terraform init"){
             when { 
                expression{
                     BRANCH_NAME != "main"   
                }
            }
            steps{
				ansiColor('vga'){
					withAWS(credentials: "$AWS_CREDENTIALS", region: "$AWS_REGION") {
							sh "terraform  init"
                            sh "terraform validate"
					}
				}
            }
        }
        stage("Terraform plan"){
             when { 
                expression{
                     BRANCH_NAME != "main"   
                }
            }
            steps{
                ansiColor('vga'){
                    withAWS(credentials: "$AWS_CREDENTIALS", region: "$AWS_REGION") {
                        sh "terraform  plan"
                    }
                }
            }
        }
        stage('Terraform init-Apply UAT'){
            environment {
                TF_VAR_app_environment="uat"
            }
            when { 
                expression{ return params.CreateResources }
                expression{ return !params.DestroyResources}
                expression{
                     BRANCH_NAME == "main"   
                }
            }
            steps{
				ansiColor('vga'){
					withAWS(credentials: "$AWS_CREDENTIALS", region: "$AWS_REGION") {
                        script{
                            sh "terraform init"
                        }
					}
				}
            }
        }
        stage('Terraform apply-UAT'){
            environment {
                TF_VAR_app_environment="uat"
            }
            when { 
                expression{ return params.CreateResources }
                expression{ return !params.DestroyResources}
                expression{
                     BRANCH_NAME == "main"   
                }
            }
            steps{
				ansiColor('vga'){
					withAWS(credentials: "$AWS_CREDENTIALS", region: "$AWS_REGION") {
                        script{
                            gv.terraform(env.APPLY, env.TF_VAR_app_environment)
                        }
					}
				}
            }
        }
        stage('Terraform init-Destroy UAT'){
            environment {
                TF_VAR_app_environment="uat"
            }
            when { 
                expression{ return !params.CreateResources }
                expression{ return params.DestroyResources }
                expression{
                     BRANCH_NAME == "main"
                }
            }
            steps{
				ansiColor('vga'){
					withAWS(credentials: "$AWS_CREDENTIALS", region: "$AWS_REGION") {
                        script{
                            sh "terraform init"
                        }					
					}
				}
            }
        }
        stage('Terraform destroy-UAT'){
            environment {
                TF_VAR_app_environment="uat"
            }
            when { 
                expression{ return !params.CreateResources }
                expression{ return params.DestroyResources }
                expression{
                     BRANCH_NAME == "main"
                }
            }
            steps{
				ansiColor('vga'){
					withAWS(credentials: "$AWS_CREDENTIALS", region: "$AWS_REGION") {
                        script{
                            gv.terraform(env.DESTROY, env.TF_VAR_app_environment)
                        }					
					}
				}
            }
        }
        stage('Terraform init-Apply Pro'){
            environment {
                TF_VAR_app_environment="pro"
            }
            when { 
                expression{ return params.CreateResources_to_Production }
                expression{ return !params.DestroyResources_from_Production}
                expression{
                     BRANCH_NAME == "main"   
                }
            }
            steps{
				ansiColor('vga'){
					withAWS(credentials: "$AWS_CREDENTIALS", region: "$AWS_REGION") {
                        script{                       
                            sh "terraform init -backend-config='key=offerripple-front-pro.tfstate' -backend-config='dynamodb_table=offerripple-front-pro-lock-dynamo'"
                        }
					}
				}
            }
        }
        stage('Terraform apply-Pro'){
            environment {
                TF_VAR_app_environment="pro"
            }
            when { 
                expression{ return params.CreateResources_to_Production }
                expression{ return !params.DestroyResources_from_Production}
                expression{
                     BRANCH_NAME == "main"   
                }
            }
            steps{
				ansiColor('vga'){
					withAWS(credentials: "$AWS_CREDENTIALS", region: "$AWS_REGION") {
                        script{                       
                            gv.terraform(env.APPLY, env.TF_VAR_app_environment)
                        }
					}
				}
            }
        }
         stage('Terraform init-Destroy Pro'){
            environment {
                TF_VAR_app_environment="pro"
            }
            when { 
                expression{ return !params.CreateResources_to_Production }
                expression{ return params.DestroyResources_from_Production }
                expression{
                     BRANCH_NAME == "main"
                }
            }
            steps{
				ansiColor('vga'){
					withAWS(credentials: "$AWS_CREDENTIALS", region: "$AWS_REGION") {
                        script{                   
                           sh "terraform init -backend-config='key=offerripple-front-pro.tfstate' -backend-config='dynamodb_table=offerripple-front-pro-lock-dynamo'"                  
                        }					
					}
				}
            }
        }
        stage('Terraform destroy-Pro'){
            environment {
                TF_VAR_app_environment="pro"
            }
            when { 
                expression{ return !params.CreateResources_to_Production }
                expression{ return params.DestroyResources_from_Production }
                expression{
                     BRANCH_NAME == "main"
                }
            }
            steps{
				ansiColor('vga'){
					withAWS(credentials: "$AWS_CREDENTIALS", region: "$AWS_REGION") {
                        script{                   
                            gv.terraform(env.DESTROY, env.TF_VAR_app_environment)                     
                        }					
					}
				}
            }
        }
    }

	post {
        failure {
            echo "Terraform pipeline execution failed!"
        }
        success {
            echo "Terraform pipeline execution succeeded!"
        }
		always {
			script {
                try{
                    cleanWs()
                }catch(Exception e) {
                    echo "Error: ${e}"
                    echo "clean failed!"
                }
            }
		}
	}	
}