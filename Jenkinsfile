pipeline{
    agent any
    environment {
        MYSQL_DATABASE_HOST = "database"
        MYSQL_DATABASE_PASSWORD = "Clarusway_1"
        MYSQL_DATABASE_USER = "admin"
        MYSQL_DATABASE_DB = "phonebook_db"
        MYSQL_DATABASE_PORT = 3306
        PATH="/usr/local/bin/:${env.PATH}"
    }
    stages{
        stage("compile"){
            agent { docker { image 'python:alpine' } }
            steps{
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'pip install -r requirements.txt'
                    sh 'python -m py_compile app/*.py'
                    stash(name: 'compilation_result', includes: 'app/*.py*')
                }   
            }
        }

        stage('build'){
            agent any
            steps{
                sh "docker build -t matt/handson-jenkins ."
                sh "docker tag matt/handson-jenkins:latest 724850377345.dkr.ecr.us-east-1.amazonaws.com/project-repo"
            }
        }
        stage('push'){
            agent any
            steps{
                sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 724850377345.dkr.ecr.us-east-1.amazonaws.com"
                sh "docker push 724850377345.dkr.ecr.us-east-1.amazonaws.com/project-repo"
            }
        }

        stage('compose'){
            agent any
            steps{
                sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 724850377345.dkr.ecr.us-east-1.amazonaws.com"
                sh "docker-compose up -d"
            }
        }
    }
}

