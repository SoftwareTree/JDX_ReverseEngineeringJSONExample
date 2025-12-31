#!/bin/bash

# Set environment variables by sourcing the setEnvironment.sh script
source ./setEnvironment.sh

# Run the Java command
java com.softwaretree.jdxtools.JDXSchema -reverseEng config/mysql_sakila_example_template.config

