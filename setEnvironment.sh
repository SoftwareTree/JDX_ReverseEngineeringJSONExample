#!/bin/bash
# Please make sure to replace /path/to/mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar with the actual absolute or relative path to the MySQL JDBC jar on your system

# Set classpath
export CLASSPATH=".:./bin:./config:$JX_HOME/config:$JX_HOME/libs/jxclasses.jar:$JX_HOME/libs/jdxtools.jar:$JX_HOME/external_libs/json-20240303.jar:/path/to/mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar"

