pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'JDK21'
    }

    stages {

        stage('Scrutation SCM') {
            steps {
                checkout scm
                echo 'Code récupéré depuis GitHub'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Analyse du code') {
            steps {
                bat 'mvn checkstyle:checkstyle pmd:pmd pmd:cpd spotbugs:spotbugs'
            }
        }

        stage('JavaDoc') {
            steps {
                bat 'mvn javadoc:javadoc'
            }
        }

        stage('Package') {
            steps {
                bat 'mvn package -DskipTests'
            }
        }

        stage('Archivage') {
            steps {
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
                echo 'WAR archivé dans Jenkins'
            }
        }

        stage('Deploiement Nexus') {
            steps {
                bat 'mvn deploy -DskipTests -s settings-nexus.xml'
            }
        }
    }

    post {
        success {
            mail to: 'ismailbinar754@gmail.com',
                 subject: "BUILD SUCCESS - GameVerseAcademy #${BUILD_NUMBER}",
                 body: "Le build #${BUILD_NUMBER} a réussi.\n\nURL: ${BUILD_URL}"
        }
        failure {
            mail to: 'ismailbinar754@gmail.com',
                 subject: "BUILD FAILURE - GameVerseAcademy #${BUILD_NUMBER}",
                 body: "Le build #${BUILD_NUMBER} a échoué.\n\nURL: ${BUILD_URL}\n\nVérifiez les logs."
        }
    }
}