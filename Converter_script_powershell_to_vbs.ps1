<#
.SYNOPSIS
    Conversor_script.ps1
.DESCRIPTION
    Este script tem como função criar um script .vbs executável a partir de um script powershell.
.EXAMPLE
    C:\PS> .\Conversor_script.ps1 -caminho .\Get-Hot-Fix.txt -destino .\script.vbs
.NOTES
    Author: Jonathan Goya Nogiri
    Date:   March 08, 2016    
.VERSION
 v1 Converte o script em base64
 v2 Converte o script em vbs

.CONTRIBUTORS
 Fred Crespo, Sean Metcalf, Siva Mulpuru
#>

param(
	[Parameter(Mandatory=$True,Position=1)]
	[string]$caminho,
	[Parameter(Mandatory=$True)]
	[string]$destino
)

# Pega o conteúdo do script
$Text = Get-Content $caminho

# Encoda o conteúdo do arquivo em Base64
$ubytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$encodedcmd = [Convert]::ToBase64String($ubytes) 

# Monta o comando do script vbs
$ComandoVBS = 'command = "powershell.exe -NoP -NonI -W Hidden -Enc ' + $encodedcmd + '"'

# Cria o arquivo vbs
echo 'Dim objShell' > $destino
echo 'Set objShell = WScript.CreateObject("WScript.Shell")' >> $destino
echo $ComandoVBS >> $destino
echo 'objShell.Run command,0' >> $destino
echo 'Set objShell = Nothing' >> $destino

