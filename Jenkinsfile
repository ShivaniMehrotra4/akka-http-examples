pipeline {
	agent any

	options {
		retry(2)
		timeout(time: 15, unit: 'MINUTES') // minutes bydefault
	}
	triggers{ 
		cron('H H 1,15 1-11 *') 
	}
	environment {
		sbt_path = '/home/knoldus/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt'
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
						sh '$sbt_path clean compile'
					}
				}
				stage('Compile - stage 1 @ slave 2') {
					agent {
						label 'ubuntu-slave-2'
					}
					steps {
						sh '$sbt_path clean compile'
					}
				}
			}
		}
		
		stage('Test stages in parallel on slaves') {
			when {
				branch 'test-branch'
			}
			parallel {
				stage('Test - stage 2 @slave 1') {
					agent {
						label 'ubuntu-slave-1'
					}
					steps {
						sh '$sbt_path test'
					}
				}
				stage('test - stage 2 @slave 2') {
					agent {
						label 'ubuntu-slave-2'
					}
					steps {
						sh '$sbt_path test'
					}
				}
			}
		}
	

		stage('Packaging-step Producing Jar') {
			when {
				branch 'master'
			}
			agent {
				label 'ubuntu-slave-1'	
			}
			steps {
				sh '$sbt_path assembly'
			}
		}

		stage('Deploy') {
			when {
				branch 'master'
			}
			agent {
				label 'ubuntu-slave-1'	
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
				sh './deployScript.sh'
			}
		}
	}

	post {
		always {
			echo "I execute always."
			mail to: 'shivanimehrotra.sms@gmail.com',
                      	subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) has been completed.",
                      	body: "Please go to ${BUILD_URL} and check for the status"

		}

		failure {
			echo 'There was a failure'
		}

		success {
			echo 'I am executed only when there is a success.'
			echo 'Cleaning up the workspace now'
			cleanWs()
		}

		aborted {
			echo 'I am executed only when the build is aborted/ stopped manually.'
		}
	}

}
