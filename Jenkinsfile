pipeline {
	agent any

	options {
		retry(3)
		timeout(5)  // minutes bydefault
	}

	
	stages {

		stage('sbt-install in parallel on slaves') {
			parallel {
				stage('sbt install - stage 1 @ slave1') {
					agent {
						label 'ubuntu-slave-1'
					}
					steps {
						tool name: 'sbt', type: 'org.jvnet.hudson.plugins.SbtPluginBuilder$SbtInstallation'
					}
				}
				stage('sbt install - stage 1 @ slave 2') {
					agent {
						label 'ubuntu-slave-2'
					}
					steps {
						tool name: 'sbt', type: 'org.jvnet.hudson.plugins.SbtPluginBuilder$SbtInstallation'
					}
				}
			}
		}

		// stage('Sbt - install') {
		// 	steps {
		// 		tool name: 'sbt', type: 'org.jvnet.hudson.plugins.SbtPluginBuilder$SbtInstallation'
		// 	}
		// }

		// stage('Compile') {
		// 	steps {
		// 		sh '/home/knoldus/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt clean compile'	
		// 	}
		// }


		stage('Compile stages in parallel on slaves') {
			parallel {
				stage('Compile - stage 1 @ slave1') {
					agent {
						label 'ubuntu-slave-1'
					}
					steps {
						sh '/home/knoldus/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt clean compile'
					}
				}
				stage('Compile - stage 1 @ slave 2') {
					agent {
						label 'ubuntu-slave-2'
					}
					steps {
						sh '/home/knoldus/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt clean compile'
					}
				}
			}
		}
		
		stage('Test stages in parallel on slaves') {
			parallel {
				stage('Test - stage 2 @slave 1') {
					agent {
						label 'ubuntu-slave-1'
					}
					when {
						branch 'test-branch'
					}
					steps {
						sh '/home/knoldus/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt test'
					}
				}
				stage('test - stage 2 @slave 2') {
					agent {
						label 'ubuntu-slave-2'
					}
					when {
						branch 'test-branch'
					}
					steps {
						sh '/home/knoldus/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt test'
					}
				}
			}
		}
	}

	stage('Packaging-step Producing Jar') {
		when {
			branch 'master'
		}
		steps {
			sh '/home/knoldus/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt assembly'
		}
	}

	stage('Deploy') {
		when {
			branch 'master'
		}
		input {
  			message 'Up for deployment ?'
  			id 'deploy-id'
  			ok 'Yeah !'
  			submitterParameter 'deploy-result'
  			parameters {
    			string defaultValue: 'Yes', description: '', name: 'deploy-result', trim: false
  			}
		}

		steps {
			echo "Ready to take-off (deploy) !!"
			//sh './deployScript.sh'
		}
	}

	post {
		always {
			echo "I execute always."
			mail bcc: '', body: '''Hey !
			************************************
			Job Name : ${JOB_NAME}
			Build Number : ${BUILD_NUMBER}
			Build Name : ${BUILD_DISPLAY_NAME}
			Build Status : ${currentBuild.result}
			************************************''', cc: '', from: '', replyTo: '', subject: 'Status Jenkins Pipeline ', to: 'shivanimehrotra.sms@gmail.com'

		}

		failure {
			echo 'I am executed only when there is a failure.'

		}

		success {
			echo 'I am executed only when there is a success.'
		}

		aborted {
			echo 'I am executed only when the build is aborted/ stopped manually.'
		}
	}

}
