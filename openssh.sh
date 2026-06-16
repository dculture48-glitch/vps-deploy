#!/bin/bash
/usr/sbin/sshd

sleep 2

echo ""
echo "=== Starting bore tunnel for SSH ==="
bore local 22 --to bore.pub &
BORE_PID=$!

sleep 5

echo ""
echo "=== VPS is running! ==="
echo "Connect using: ssh root@bore.pub -p <PORT shown above>"
echo "ROOT Password: craxid"
echo "========================"

wait $BORE_PID
