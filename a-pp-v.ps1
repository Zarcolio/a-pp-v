# This script has been created by Zarco Zwier, Aug 6th, 2017
# This script can freely be re-used and distributed as long as this comment remains.
# WARNING: THIS SCRIPT MESSES WITH YOUR SUBSTED OR NETWORK MAPPED DRIVES!
# USE AT YOUR OWN RISK AND ONLY FOR BENIGN PURPOSES!

param (
	[string]$method = "subst",
	[string]$hideq
)

function DriveMapping {
	Param([char]$letterStart,[char]$LetterEnd,[string]$Method, [bool]$Enabled)
	
	$DriveMappings = @()
		
	For ([byte]$l = [char]$letterStart; $l -le [char]$LetterEnd; $l++){	
		$letter = [char[]]$l

		If ($method.toLower() -eq "subst") {
			$EnableDrive= "SUBST "+$letter+": C:\"
			$DisableDrive="SUBST "+$letter+": /D"
		}

		If ($method.toLower() -eq "netuse") {
			$EnableDrive= "NET USE "+$letter+": \\localhost\C$"
			$DisableDrive="NET USE "+$letter+": /DELETE"
		}
		
		If ($Enabled -eq $True -and !(Test-Path $Letter":")) {
			$output = & cmd.exe /c $EnableDrive
			$DriveMappings+=$Letter
		}
		
		# Temp, because of next if loop and annoying array behaviour
		$output = & cmd.exe /c $DisableDrive
		
		If ($Enabled -eq $False) {
			write-host $DriveMappings
			If ($DriveMappings -contains $Letter) {
				$output = & cmd.exe /c $DisableDrive
				write-host $DriveMappings}
		}
	}
} 

Write-Host "Creating C: - P: and waiting for Q:"
DriveMapping -letterStart 'C' -letterEnd 'P' -Method "subst" -Enabled $True

While (!(Get-PsDrive | Where{$_.Name -eq 'Q'})) {}

Write-Host "Q: detect, removing C: - P:"
DriveMapping -letterStart 'C' -letterEnd 'P' -Method "subst" -Enabled $False
