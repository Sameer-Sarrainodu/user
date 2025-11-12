@Library('jenkins-shared-Library') _

def configMap = [
    project : "roboshop"
    component : "user"
] 

if(! env.BRANCH_NAME.equalsIgnoreCase("main")){
    nodejsEksPipeline(configMap)
}
else{
    echo "Please proceed with Prod"
}