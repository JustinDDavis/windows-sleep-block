# Script for keeping machine awake
Using the global settings, script will check every determined about of time if 
cursor had moved. If it has, the script will keep checking to find when you
have stepped away from the machine. When the cursor stays still, the script 
will launch notepad and begin posting the current date and time. If the mouse
moves, the script will terminate the notepad process and wait again. 

# Summary
## To use
    - Save PowerShell file on desktop
    - Open Powershell App
    - Launch ".\main.ps1"
        - If notepad begins to run, just move mouse and wait a few seconds for it to shutdown