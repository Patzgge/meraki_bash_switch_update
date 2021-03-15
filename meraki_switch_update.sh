#!/bin/bash

baseurl=https://api.meraki.com/api/v0/
apikey=Enter API Key here
networkid=Enter network ID here
access01_serial=Enter Switch one serial number here
access02_serial=Enter Switch two serial number here
headerurl=( --header 'Accept: */*' --header 'Content-Type: application/json' --header 'X-Cisco-Meraki-API-Key: '$apikey )


curl --location --request POST $baseurl'networks/'$networkid'/devices/'$access01_serial'/remove' "${headerurl[@]}"  \
--data-raw '';

curl --location --request POST $baseurl'networks/'$networkid'/devices/'$access01_serial'/remove' "${headerurl[@]}"  \
--data-raw '';

curl --location --request POST $baseurl'networks/'$networkid'/devices/'$access02_serial'/remove' "${headerurl[@]}"  \
--data-raw '';

curl --location --request POST $baseurl'networks/'$networkid'/devices/claim' "${headerurl[@]}"  \
--data-raw '{
  "serials": [
    "Enter Switch one serial number here",
    "Enter Switch two serial number here"

  ]
}';

curl --location --request PUT $baseurl'networks/'$networkid'/devices/'$access01_serial "${headerurl[@]}"  \
--data-raw '{
              "name": "Access01",
              "address": "Street & house number,\nZip code and city,\nCountry"
}';

curl --location --request PUT $baseurl'networks/'$networkid'/devices/'$access02_serial "${headerurl[@]}"  \
--data-raw '{
              "name": "Access02",
              "address": "Street & house number,\nZip code and city,\nCountry"
}';

curl --location --request PUT $baseurl'devices/'$access01_serial'/switchPorts/1' "${headerurl[@]}"  \
--data-raw '{
              "name": "Cisco IP Phone",
              "enabled": true,
              "poeEnabled": true,
              "type": "access",
              "vlan": 1,
              "allowedVlans": "all",
              "isolationEnabled": false,
              "rstpEnabled": true,
              "stpGuard": "disabled",
              "linkNegotiation": "Auto negotiate",
              "udld": "Alert only"

}';

curl --location --request PUT $baseurl'devices/'$access01_serial'/switchPorts/2' "${headerurl[@]}"  \
--data-raw '{
              "name": "HP Drucker",
              "enabled": true,
              "poeEnabled": true,
              "type": "access",
              "vlan": 1,
              "allowedVlans": "all",
              "isolationEnabled": false,
              "rstpEnabled": true,
              "stpGuard": "disabled",
              "linkNegotiation": "Auto negotiate",
              "udld": "Alert only"
}';

curl --location --request PUT $baseurl'devices/'$access01_serial'/switchPorts/7' "${headerurl[@]}"  \
--data-raw '{
              "name": "AccessPoint",
              "enabled": true,
              "poeEnabled": true,
              "type": "trunk",
              "vlan": 1,
              "allowedVlans": "all",
              "isolationEnabled": false,
              "rstpEnabled": true,
              "stpGuard": "disabled",
              "linkNegotiation": "Auto negotiate",
              "udld": "Alert only"
}';

curl --location --request PUT $baseurl'devices/'$access01_serial'/switchPorts/8' "${headerurl[@]}"  \
--data-raw '{
              "name": "UPLink Distribution01",
              "enabled": true,
              "poeEnabled": true,
              "type": "trunk",
              "vlan": 1,
              "allowedVlans": "all",
              "isolationEnabled": false,
              "rstpEnabled": true,
              "stpGuard": "disabled",
              "linkNegotiation": "Auto negotiate",
              "udld": "Alert only"
}';

for portid in $(seq 3 6); do
  curl --location --request PUT $baseurl'devices/'$access01_serial'/switchPorts/'$portid "${headerurl[@]}"  \
  --data-raw '{
                "name": "Client",
                "enabled": true,
                "poeEnabled": true,
                "type": "access",
                "vlan": 1,
                "allowedVlans": "all",
                "isolationEnabled": false,
                "rstpEnabled": true,
                "stpGuard": "disabled",
                "linkNegotiation": "Auto negotiate",
                "udld": "Alert only"
              }';
done

curl --location --request PUT $baseurl'devices/'$access02_serial'/switchPorts/8' "${headerurl[@]}"  \
--data-raw '{
              "name": "UPLink Distribution01",
              "enabled": true,
              "poeEnabled": true,
              "type": "trunk",
              "vlan": 1,
              "allowedVlans": "all",
              "isolationEnabled": false,
              "rstpEnabled": true,
              "stpGuard": "disabled",
              "linkNegotiation": "Auto negotiate",
              "udld": "Alert only"
}';

for portid in $(seq 1 7); do
  curl --location --request PUT $baseurl'devices/'$access02_serial'/switchPorts/'$portid "${headerurl[@]}"  \
  --data-raw '{
                "name": "Client",
                "enabled": true,
                "poeEnabled": true,
                "type": "access",
                "vlan": 1,
                "allowedVlans": "all",
                "isolationEnabled": false,
                "rstpEnabled": true,
                "stpGuard": "disabled",
                "linkNegotiation": "Auto negotiate",
                "udld": "Alert only"
              }';
done

echo "Fertig"
