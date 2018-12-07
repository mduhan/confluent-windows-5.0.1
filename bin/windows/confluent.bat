start  zookeeper-start.bat
timeout 10
start kafka-start.bat
timeout 40
start schema-registry-start.bat
start worker-start.bat