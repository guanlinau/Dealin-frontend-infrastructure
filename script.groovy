#!/usr/bin/env groovy
def terraform(String ACTION, String ENVIRONMENT) {
    def maxAttempts =env.MAXATTEMPTS as Integer
    for (int attempt = 1; attempt <=maxAttempts; attempt++){
        try{
            // conduct terraform action!
            sh "terraform ${ACTION} -auto-approve -var 'app_environment=${env.TF_VAR_app_environment}'"
            // break if succeed!
            break
        }catch(Exception e){
            if(attempt==maxAttempts){
                throw e
            }
            echo "Terraform ${ACTION} failed on attempt ${attempt}, retrying or fixing issues..."
        }
    }
}

return this;