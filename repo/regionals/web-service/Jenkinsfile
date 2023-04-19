pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh '''
                image_tag=$(git rev-parse HEAD)
                docker build -t webapp:${image_tag} .
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                echo 'linting'
                echo 'completed 100%'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Pushing Image'
                sh '''
                image_tag=$(git rev-parse HEAD)
                docker tag webapp:${image_tag} localhost:5000/webapp:${image_tag}
                docker push localhost:5000/webapp:${image_tag}
                '''
            }
        }
    }
}
