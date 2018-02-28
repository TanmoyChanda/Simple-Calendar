pipeline 
{
agent any
    
    stages{
		stage('Checkout') {
			steps{
							checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/TanmoyChanda/Simple-Calendar']]])
						   }
					}	   
		stage('Build') {
			steps{
				 
				sh 'export SDK_ROOT=/var/lib/jenkins/tools/android-sdk && export ANDROID_HOME=/var/lib/jenkins/tools/android-sdk && /var/lib/jenkins/workspace/DevOps_on_Android/gradlew build'
				sh 'cd ${WORKSPACE}/app/build/outputs/apk/release'
				sh 'mv calendar-release-unsigned.apk calendar-release${BUILD_NUMBER}-unsigned.apk'


				  
			    }
		}
	}
}	
