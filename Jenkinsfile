def nginxImg
node{
    stage('Checkout'){
        checkout([$class: 'GitSCM', branches: [[name: '*/Jenkins']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/mailsyarief/tugas_akhir']]])
    }
    stage('Build Image'){
        nginxImg = docker.build('mailsyarief/coba_nginx:dev','./docker/.')
    }
    stage('Build Helm Chart'){
        echo "Building helm chart"
    }
    stage('Push to Docker Registry'){
        sh 'docker login --username mailsyarief -p 02fdd2f6-078c-4ce5-915d-0529733d5a7d'
        nginxImg.push()
    }
    stage('Deploy to Rancher'){
        
        withKubeConfig(caCertificate: '', clusterName: 'sanbox', contextName: 'sanbox', credentialsId: '2e0d3245-bcee-40eb-b76b-c81180872c0a', namespace: 'default', serverUrl: 'https://10.151.31.168/k8s/clusters/c-fc8g7') {
            // some block
            //sh 'kubectl create deployment nginx --image=nginx'
            try{
                sh 'helm upgrade --recreate-pods helmchart ./helmchart'
            }catch  (Exception e){
                sh 'helm install helmchart ./helmchart'
            }
        }
    }
}
