@echo off
rem Licensed to the Apache Software Foundation (ASF) under one or more
rem contributor license agreements.  See the NOTICE file distributed with
rem this work for additional information regarding copyright ownership.
rem The ASF licenses this file to You under the Apache License, Version 2.0
rem (the "License"); you may not use this file except in compliance with
rem the License.  You may obtain a copy of the License at
rem
rem    http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.

IF [%1] EQU [] (
	echo USAGE: %0 connect-standalone.properties
	EXIT /B 1
)

SetLocal
rem Using pushd popd to set BASE_DIR to the absolute path
pushd %~dp0..\..
set BASE_DIR=%CD%
popd

rem Log4j settings
IF ["%KAFKA_LOG4J_OPTS%"] EQU [""] (
    if exist %~dp0../../etc/kafka/tools-log4j.properties (
        set KAFKA_LOG4J_OPTS=-Dlog4j.configuration=file:%~dp0../../etc/kafka/tools-log4j.properties
    ) else (
        set KAFKA_LOG4J_OPTS=-Dlog4j.configuration=file:%BASE_DIR%/config/tools-log4j.properties
    )
)

rem Classpath additions for Confluent Platform releases
for %%p in (confluent-common kafka-serde-tools monitoring-interceptors) do (
    if exist %BASE_DIR%\share\java\%%p (
        call :concat %BASE_DIR%\share\java\%%p\*
   )
)

"%~dp0kafka-run-class.bat" org.apache.kafka.connect.cli.ConnectStandalone %*
EndLocal

goto :eof
:concat
IF ["%CLASSPATH%"] EQU [""] (
    set "CLASSPATH=%1"
) ELSE (
    set "CLASSPATH=%CLASSPATH%;%1"
)
