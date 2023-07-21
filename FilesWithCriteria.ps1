# Schreiben Sie eine PS Funktion, die rekursiv einen Verzeichnisbaum durchsucht
# und alle Dateien mit bestimmten Kriterien ermittelt. Die kriterien für die Datei sollen an
# die Funktion als Parameter übergeben werden. Die Funktion soll die gefundenen Dateien in
# einem geeigneten Format ausgeben

# Kriterien:
# 1. Die Datei muss die Erweiterung ".txt" haben
# 2. Die Datei muss größer als 1MB sein
# 3. Die Datei muss mindestens 5 Zeilen Text enthalten, wobei jede Zeile mind. 50
# Zeichen lang sein muss

# Hinweise:
# Die Funktion sollte den Startpfad des Verzeichnisbaums und die Kriterien als Parameter
# akzeptieren
# Sie können die PowerShell Cmdlets wie (Get-ChildItem, Select-String, Measure-Object) usw
# verwenden um die Dateien zu filtern und die Kriterien zu überprüfen
# Stellen Sie sicher, dass die Funktion rekursiv alle Unterverzeichnisse durchläuft
# Die Ausgabe kann bspw. den Dateinamen, den Pfad und die Größe der Datei enthalten

function Get-FilesWithCriteria {
    param (
        [string]$path,
        [string]$extension,
        [int]$minSizeMB,
        [int]$minLines,
        [int]$minLineLength
    )

    $files = Get-ChildItem $path -Recurse | Where-Object { $_.Extension -eq $extension -and $_.Length -gt ($minSizeMB * 1MB) }

    foreach ($file in $files) {
        $content = Get-Content $file.FullName
        $lineCount = $content.Count
        $longLineCount = ($content | Where-Object { $_.Length -ge $minLineLength }).Count

        if ($lineCount -ge $minLines -and $longLineCount -ge $minLines) {
            Write-Output "Dateiname: $($file.Name)"
            Write-Output "Pfad: $($file.FullName)"
            Write-Output "Dateigröße: $([math]::Round($file.Length / 1MB, 2)) MB"
            Write-Output "Anzahl der Zeilen: $lineCount"
            Write-Output "Anzahl der Zeilen mit mindestens $minLineLength Zeichen: $longLineCount`n"
        }
    }
}

# Beispielaufruf:
$directoryPath = "C:\Pfad\Zum\Verzeichnis"
$extension = ".txt"
$minSizeMB = 1
$minLines = 5
$minLineLength = 50

Get-FilesWithCriteria -path $directoryPath -extension $extension -minSizeMB $minSizeMB -minLines $minLines -minLineLength $minLineLength