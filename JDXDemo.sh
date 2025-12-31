#!/bin/bash

# Call the setEnvironment script (if it's another shell script or executable)
source ./setEnvironment.sh

# Run the Java command
java com.softwaretree.jdxtools.JDXDemo config/JDXDemo.config

