#!/bin/bash
#
# Check Point Firewall Connections Delete From Connection Table
#


echo "Check Point Firewall Connections Delete From Connection Table" 


help_usage() { 
	echo -e "\nUsage:\n" 
    echo -e "\t $0 <Source> <Destination>"
    echo -e "\t $0 <Source> <Destination> <Source-Port>"
    echo -e "\t $0 <Source> <Destination> <Destinion-Port>"
    echo -e "\t $0 <Source> <Destination> <Source-Port> <Destinion-Port>"
    echo -e "\n\t e.g.\n"
    echo -e "\t $0 10.10.10.10 20.20.20.20 443 3000"
    echo -e "" 
	} 



# usage
if [  $#  -le 0 ] 
then 
    help_usage
    exit 1
fi 

if [[ ( $# == "--help") ||  $# == "-h" ]] 
then 
    help_usage
    exit 0
fi 

#Read input for IP and/or Port values  values 
IPA=$1
IPB=$2
DPORT=$3
SPORT=$4


#The Decimal to Hex conversion
IPAHEX=$(printf '%02x' ${IPA//./ })
IPBHEX=$(printf '%02x' ${IPB//./ })
DPORTHEX=$(printf '%08x' ${DPORT//./ })
SPORTHEX=$(printf '%08x' ${SPORT//./ })


echo
# collect the tables from all SGMs in Maestro cluster, save to a file called 'conn_table'
g_fw tab -t connections -u > conn_table

# collect the tables from standalone firewall, save to a file called 'conn_table'
# fw tab -t connections -u > conn_table

# filter for IP addresses we want to clear, format the command, save to a file called 'listofall' for all SGMs in Maestro cluster
grep "$IPAHEX" conn_table | grep "$IPBHEX" | grep "$DPORTHEX" | grep "$SPORTHEX" | grep "^<0000000" | awk '{print $1" "$2" "$3" "$4" "$5" "$6}' |sed 's/ //g'|sed 's/</g_fw tab -t connections -x -e /g'|sed 's/>//g'|sed 's/;//g' > listofall

# filter for IP addresses we want to clear, format the command, save to a file called 'listofall' for standalone firewall
# grep "$IPAHEX" conn_table | grep "$IPBHEX" | grep "$DPORTHEX" | grep "$SPORTHEX" | grep "^<0000000" | awk '{print $1" "$2" "$3" "$4" "$5" "$6}' |sed 's/ //g'|sed 's/</fw tab -t connections -x -e /g'|sed 's/>//g'|sed 's/;//g' > listofall


#Execute commands generated in the file
echo -e "\nThese connections were found in the connection table:"
echo
tail  listofall 
COUNT=$(cat listofall | wc -l)
echo -e "\nTotal Connection Counts: $COUNT "
if [[ ( $COUNT != 0) ]] 
then
echo "Do you want to delete them?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo ; echo "Starting delete connections..."; /bin/bash listofall; echo "These connections were deleted"; break;;
        No ) echo "Canceled..."; exit;;
    esac
done
fi