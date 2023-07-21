$MAOrdner = Get-ChildItem -Path "C:\Lohn" -Directory

foreach($MA in $MAOrdner)
{
    $files = "C:\Lohn\" + $MA


        
            $NeuerOrdnerInstall = $files
        if((Test-Path "$files\ArbeitszeitErfassung" -PathType Container) -ne $True)
        {
            $OrdnernameInstall = New-Item -Path "$files\ArbeitszeitErfassung" -ItemType "directory"

            Write-Host "in Ordner: $NeuerOrdnerInstall\ArbeitszeitErfassung erstellt"
        }
        else {            

            Write-Host "$NeuerOrdnerInstall\ArbeitszeitErfassung existiert bereits."
        }

            $Rechte = Get-Acl -Path "$files\Krankenmeldungen" 
            Set-Acl -Path "$files\ArbeitszeitErfassung" -AclObject $Rechte

}