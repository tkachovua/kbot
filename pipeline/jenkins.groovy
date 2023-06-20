pipeline {
    agent any
        environment {
            REPO = 'https://github.com/tkachovua/kbot'
            BRANCH = 'main'
        }
    parameters {
        choice(
            name: 'OS',
            choices: ['linux', 'windows', 'darwin'],
            description: 'Select the target OS'            
        )
        choice(
            name: 'ARCH',
            choices: ['amd64', 'arm64'],
            description: 'Select the target ARCH'            
        )
    }
    stages {
        stage('Example') {
            steps {
                echo "Build for platform ${params.OS}"

                echo "Build for arch: ${params.ARCH}"
            }
        }
        stage("clone") {
            steps {
                echo 'CLONE REPOSITORY'
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }
        stage("test") {
            steps {
                echo 'TEST EXECUTION STARTED '
                sh 'make test'
            }
        }
        stage("build") {
            steps {
                echo 'BUILD EXECUTION STARTED '
                sh 'make build'
            }
        }
        stage("image") {
            steps {
                script {
                    echo 'BUILD IMAGES EXECUTION STARTED '
                    sh 'make image'
                }
            }
        }
        stage("push") {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub') {
                        sh 'make push'
                    }
                }
            }
        }
    }
}