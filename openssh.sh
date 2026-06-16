#!/bin/bash
REGION=${REGION:-ap}

/ngrok tcp --authtoken "${NGROK_TOKEN}" --region "${REGION}" 22 &

sleep 5

curl -s http://localhost:4040/api/tunnels | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    url = data['tunnels'][0]['public_url'][6:]
    host, port = url.split(':')
    print('\n=== SSH Connection Info ===')
    print(f'ssh root@{host} -p {port}')
    print('ROOT Password: craxid')
    print('==========================\n')
except Exception as e:
    print(f'Error getting tunnel info: {e}')
    print('Check NGROK_TOKEN is valid')
" || echo "Error: Could not get tunnel info. Check NGROK_TOKEN."

/usr/sbin/sshd -D
