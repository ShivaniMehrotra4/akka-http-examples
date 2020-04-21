#!/bin/bash
#
# SCRIPT: deploy.sh
# AUTHOR: Shivani Mehrotra
# DATE:   20th April,2020
# REV:    1.1.A (Valid are A, B, D, T and P)
#          (For Alpha, Beta, Dev, Test and Production)
#
#
# PLATFORM: Ubuntu
# 
# PURPOSE: Deploying the jar file onto the production server.
# REV LIST:
#    DATE        : Date of revision
#    BY          : AUTHOR OF MODIFICATION
#    MODIFICATION: Describe the chages made. What do they enhance.
# 
# set -n   # Uncomment to check script syntax, without execution.
#          # NOTE: Do forget comment it back as it won't allow the 
#          # the script to execute.
#
# set +x   # Uncomment this for debugging this shell script.
#
#
################################################################
#          Define Files and Variables here                     #
################################################################
################################################################
#          Define Functions here                               #
################################################################
################################################################
#          Beginning of Main                                   #

#scp -r ./target/scala-2.11/*.jar 34.70.153.63:~/executable
#ssh 34.70.153.63
#sudo apt install openjdk* -y
#java -jar ~/executable/*.jar

java -jar akka-http-helloworld-assembly-1.0.jar
################################################################
# End of script
