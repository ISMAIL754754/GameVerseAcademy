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
                echo ^<settings^> > nexus-settings-ci.xml
                echo   ^<servers^> >> nexus-settings-ci.xml
                echo     ^<server^> >> nexus-settings-ci.xml
                echo       ^<id^>nexus-snapshots^</id^> >> nexus-settings-ci.xml
                echo       ^<username^>%NEXUS_USER%^</username^> >> nexus-settings-ci.xml
                echo       ^<password^>%NEXUS_PASS%^</password^> >> nexus-settings-ci.xml
                echo     ^</server^> >> nexus-settings-ci.xml
                echo   ^</servers^> >> nexus-settings-ci.xml
                echo ^</settings^> >> nexus-settings-ci.xml
                mvn deploy -DskipTests -s nexus-settings-ci.xml
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