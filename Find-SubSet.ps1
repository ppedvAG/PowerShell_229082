function Find-SubsetSum {
    param(
        [int[]]$numbers,
        [int]$targetSum,
        [int[]]$currentSubset = @(),
        [int]$currentIndex = 0
    )

    if ($currentIndex -ge $numbers.Length) {
        if (($currentSubset | Measure-Object -Sum).Sum -eq $targetSum) {
            Write-Output $currentSubset
        }
        return
    }

    # Fall 1: Das aktuelle Element wird der aktuellen Teilmenge hinzugefügt
    $newSubset = $currentSubset + $numbers[$currentIndex]
    Find-SubsetSum $numbers $targetSum $newSubset ($currentIndex + 1)

    # Fall 2: Das aktuelle Element wird nicht zur aktuellen Teilmenge hinzugefügt
    Find-SubsetSum $numbers $targetSum $currentSubset ($currentIndex + 1)
}

# Beispielaufruf:
$numbers = @(2, 4, 6, 8, 10, 12, 14)
$targetSum = 20
Find-SubsetSum $numbers $targetSum