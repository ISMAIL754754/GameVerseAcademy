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
                echo 'Code recupere depuis GitHub'
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
                echo 'WAR archive dans Jenkins'
            }
        }

        stage('Deploiement Nexus') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'nexus-credentials',
                    usernameVariable: 'NEXUS_USER',
                    passwordVariable: 'NEXUS_PASS')]) {
                    bat """
                        mvn deploy -DskipTests ^
                        -Dnexus-snapshots.username=%NEXUS_USER% ^
                        -Dnexus-snapshots.password=%NEXUS_PASS% ^
                        -s settings-nexus.xml
                    """
                }
            }
        }
    }

    post {
        success {
            mail to: 'ismailbinar754@gmail.com',
                 subject: "BUILD SUCCESS - GameVerseAcademy #${BUILD_NUMBER}",
                 body: "Le build #${BUILD_NUMBER} a reussi.\n\nURL: ${BUILD_URL}"
        }
        failure {
            mail to: 'ismailbinar754@gmail.com',
                 subject: "BUILD FAILURE - GameVerseAcademy #${BUILD_NUMBER}",
                 body: "Le build #${BUILD_NUMBER} a echoue.\n\nURL: ${BUILD_URL}\n\nVerifiez les logs."
        }
    }
}