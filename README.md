# Checkpoint

Delete a specific connections entries in Checkpoint Gateway.

this script was edited for maestro firewall structure. if you have single running devices, you need to change <b>"g_fw" to "fw"

Examples:

bash del_sessions.sh 192.168.100.10 <br>
bash del_sessions.sh 192.168.100.10 172.16.50.20<br>
bash del_sessions.sh 192.168.100.10 172.16.50.20 443<br>
bash del_sessions.sh 192.168.100.10 172.16.50.20 3000 443<br>
<br>
<br>
<br>

Run script on Gateway:
1. Copy on gatewway<br>
2. set atribute for running<br>
      chmod +x del_sessions.sh
4. if script is failing to start with "/bin/bash^M: bad interpreter: no such file or directory" error. <br>
      dos2unix del_sessions.sh
6. run script on the gateway <br>
    bash del_sessions.sh 
