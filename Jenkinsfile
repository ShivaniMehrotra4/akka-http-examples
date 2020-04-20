pipeline {
	agent any

	options {
		retry(2)
	}

	
	stages {

		stage('Sbt - install') {
			steps {
				tool name: 'sbt', type: 'org.jvnet.hudson.plugins.SbtPluginBuilder$SbtInstallation'
				echo "Sbt installed"
			}
		}
	// 	stage('Compile stages in parallel on slaves') {
	// 		parallel {
	// 			stage('Compile - stage 1') {
	// 				agent {
	// 					label 'ubuntu-1'
	// 				}
	// 				steps {
	// 					sbt clean compile
	// 				}
	// 			}
	// 			stage('Compile - stage 1') {
	// 				agent {
	// 					label 'ubuntu-2'
	// 				}
	// 				steps {
	// 					sbt clean compile
	// 				}
	// 			}
	// 		}
	// 	}
		
	// 	stage('Test stages in parallel on slaves') {
	// 		parallel {
	// 			stage('Test - stage 2') {
	// 				agent {
	// 					label 'ubuntu-1'
	// 				}
	// 				steps {
	// 					sbt test
	// 				}
	// 			}
	// 			stage('test - stage 2') {
	// 				agent {
	// 					label 'ubuntu-2'
	// 				}
	// 				steps {
	// 					sbt test
	// 				}
	// 			}
	// 		}
	// 	}
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
