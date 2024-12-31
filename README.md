# Checkpoint

Delete a specific connections entries in Checkpoint Gateway.

this script was edited for maestro firewall structure. if you have single running devices, you need to change <b>"g_fw" to "fw"

Examples:

bash del_sessions.sh 192.168.100.10 <
bash del_sessions.sh 192.168.100.10 172.16.50.20
bash del_sessions.sh 192.168.100.10 172.16.50.20 443
bash del_sessions.sh 192.168.100.10 172.16.50.20 3000 443




1. Copy on gatewway
2. set atribute for running
      chmod +x del_sessions.sh
4. if script is failing to start with "/bin/bash^M: bad interpreter: no such file or directory" error. 
      dos2unix del_sessions.sh
6. run script on the gateway
    bash del_sessions.sh 
