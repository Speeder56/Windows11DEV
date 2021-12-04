@echo off
set region=ap
nslookup 0.tcp.%region%.ngrok.io > IP.txt
findstr /n "." IP.txt | findstr "5:Address:"
for /f "tokens=3 delims=: " %%i  in ('findstr /n "." IP.txt ^| findstr "5:Address:"') do set ip=%%i
curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url > tunnel.txt
powershell -Command "(gc tunnel.txt) -replace 'tcp://0.tcp.%region%.ngrok.io', '%ip%' | Out-File -encoding ASCII IP.txt"
type IP.txt
