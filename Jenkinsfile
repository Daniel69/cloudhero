node {
       stage('Checkout'){
          checkout scm
       }

        stage('Build') {
                sh 'sh gradlew build -x test'
        }
        stage('Test') {
                sh 'sh gradlew test'
        }
        stage('Archive Artifacts') {
                archiveArtifacts artifacts: '**/libs/*.jar', fingerprint: true
        }

        stage('Build Dev Docker Image') {
            sh 'docker build . -t novedadessec'
        }


        stage('Deploy') {
            sh 'export PATH=/opt/gcloud/bin/:$PATH'
            sh 'gcloud auth configure-docker'
            def IMAGE_BASE_NAME="gcr.io/salud-en-casa-202718/novedades-sec"
            def DOCKER_IMAGE="$IMAGE_BASE_NAME:$BUILD_NUMBER"

            sh "docker tag novedadessec $DOCKER_IMAGE"
            sh "docker push $DOCKER_IMAGE"

            sh "docker tag novedadessec $IMAGE_BASE_NAME"
            sh "docker push $IMAGE_BASE_NAME"

            sh "docker tag novedadessec $IMAGE_BASE_NAME:dev"
            sh "docker push $IMAGE_BASE_NAME:dev"

            sh "gcloud container clusters get-credentials salud-en-casa-dev0p"
            //sh "kubectl apply -f deploy.yaml"
            sh "kubectl set image deployment/novedades-sec-deployment novedades-sec=$DOCKER_IMAGE"

        }
}