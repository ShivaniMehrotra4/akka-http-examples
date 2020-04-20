pipeline {
	agent any

	options {
		retry(3)
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
					steps {
						sh '/home/knoldus/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt test'
					}
				}
				stage('test - stage 2 @slave 2') {
					agent {
						label 'ubuntu-slave-2'
					}
					steps {
						sh '/home/knoldus/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt test'
					}
				}
			}
		}
	}


	post {
		always {
			echo "I execute always."
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
