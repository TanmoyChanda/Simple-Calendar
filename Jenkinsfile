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
				
				  
			    }
		}

		stage('Sign Apk and archive') {
			steps{
			
				sh 'export SDK_ROOT=/var/lib/jenkins/tools/android-sdk && export ANDROID_HOME=/var/lib/jenkins/tools/android-sdk'
			 
				step([ skipZipalign: true , $class: 'SignApksBuilder', apksToSign: '**/*-unsigned.apk', keyAlias: '', keyStoreId: 'test'])
			 
				archiveArtifacts artifacts: '**/*.apk', onlyIfSuccessful: true
				
				sh 'cd ${WORKSPACE}/app/build/outputs/apk/release/ && mv calendar-release.apk calendar-release${BUILD_NUMBER}.apk'
				
				nexusArtifactUploader credentialsId: 'fa18aea1-3423-41d0-b55a-b1d319a9c5b4', groupId: 'admin', nexusUrl: '13.127.211.17:8081/nexus', nexusVersion: 'nexus2', protocol: 'http', repository: 'http://13.127.211.17:8081/nexus/content/repositories/releases/', version: '1'
				
				}
			}	
		

		stage('Upload to HockeyApp') {
			steps{
				sh '${WORKSPACE}/Upload.sh'
				}
			}	
		}

}
