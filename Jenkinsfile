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
				}
			}	

			steps {
				shell('''
				|cd target
				|curl -v -F r=maven-releases -F hasPom=false -F e=apk -F -F p=apk -F file=@app/build/outputs/apk/release/calendar-release${BUILD_NUMBER}.apk -u admin:admin123 http://13.127.211.17:8081/repository/maven-releases/
				'''.stripMargin()
        )
    }			

		stage('Upload to HockeyApp') {
			steps{
				sh '${WORKSPACE}/Upload.sh'
				}
			}	
		}

}
