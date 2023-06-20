pipeline {
    agent any

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
    }
}