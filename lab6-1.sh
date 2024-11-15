#!/bin/bash

cat /etc/hosts | while read -r ip name rest; do
  if [[ -z "$ip" || "$ip" == \#* ]]; then
    continue
  fi

  nslookup_ip=$(nslookup "$name" 2>/dev/null | grep -Eo 'Address: [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | awk '{print $2}' | tail -n1)
  
  if [[ "$nslookup_ip" && "$nslookup_ip" != "$ip" ]]; then
    echo "Bogus IP for $name in /etc/hosts! Expected $ip, but found $nslookup_ip"
  fi
done
