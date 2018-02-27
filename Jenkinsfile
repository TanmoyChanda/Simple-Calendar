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
				 
				sh 'export SDK_ROOT=/var/lib/jenkins/tools/android-sdk && export ANDROID_HOME=/var/lib/jenkins/tools/android-sdk && /var/lib/jenkins/workspace/Test-Pipeline/gradlew build'



				  
			    }
		}

		stage('Sign Apk and archive') {
			steps{
			
				sh 'export SDK_ROOT=/var/lib/jenkins/tools/android-sdk && export ANDROID_HOME=/var/lib/jenkins/tools/android-sdk'
			 
				step([ skipZipalign: true , $class: 'SignApksBuilder', apksToSign: '**/*-unsigned.apk', keyAlias: '', keyStoreId: 'test'])
			 
				archiveArtifacts artifacts: '**/*.apk', onlyIfSuccessful: true
				}
			}			

		stage('Upload to HockeyApp') {
			steps{
				sh '${WORKSPACE}/Upload.sh'
				}
			}	
		}

}
