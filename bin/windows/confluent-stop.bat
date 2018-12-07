for /f "tokens=1" %%i in ('jps -m ^| find "SchemaRegistryMain"') do ( taskkill /F /PID %%i )
for /f "tokens=1" %%i in ('jps -m ^| find "Kafka"') do ( taskkill /F /PID %%i )
for /f "tokens=1" %%i in ('jps -m ^| find "QuorumPeerMain"') do ( taskkill /F /PID %%i )
for /f "tokens=1" %%i in ('jps -m ^| find "ConnectDistributed"') do ( taskkill /F /PID %%i )


