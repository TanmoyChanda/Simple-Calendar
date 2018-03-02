pipeline {

  agent any
  stages {
    stage('Checkout Code'){
      steps {
        node('master') {
          deleteDir()
          checkout scm
          stash 'code'
        }
      }
    }	   
		stage('Build') {
			steps{
				 
				sh 'export SDK_ROOT=/var/lib/jenkins/tools/android-sdk && export ANDROID_HOME=/var/lib/jenkins/tools/android-sdk && /var/lib/jenkins/workspace/DevOps_on_Android/gradlew build'
				
				  
			    }
		}

		stage('Sign Apk and archive on Nexus') {
			steps{
			
				sh 'export SDK_ROOT=/var/lib/jenkins/tools/android-sdk && export ANDROID_HOME=/var/lib/jenkins/tools/android-sdk'
			 
				step([ skipZipalign: true , $class: 'SignApksBuilder', apksToSign: '**/*-unsigned.apk', keyAlias: '', keyStoreId: 'test'])
			 
				archiveArtifacts artifacts: '**/*.apk', onlyIfSuccessful: true
				
				sh 'cd ${WORKSPACE}/app/build/outputs/apk/release/ && mv calendar-release.apk calendar-release${BUILD_NUMBER}.apk'
				
				nexusArtifactUploader artifacts: [[artifactId: 'Calendar-app', classifier: '', file: 'app/build/outputs/apk/release/calendar-release${BUILD_NUMBER}.apk', type: 'apk']], credentialsId: 'fa18aea1-3423-41d0-b55a-b1d319a9c5b4', groupId: 'admin', nexusUrl: '13.127.211.17:8081/nexus', nexusVersion: 'nexus2', protocol: 'http', repository: 'releases', version: '${BUILD_NUMBER}'
				
				}
			}	
		stage('Testing') {
      			steps {
              			sh 'echo Testing is Going on'
            			}
         		 }

		stage('Upload to HockeyApp') {
			steps{
				sh '${WORKSPACE}/Upload.sh'
				}
			}	
		}

}
