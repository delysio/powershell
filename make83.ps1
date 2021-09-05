$inputFolder = 'c:\temp\test1\'
$outputFolder = 'c:\temp\test2\'

# CHARS DISSALOWED IN OUTPUT FILE NAMES

$disallowed = @('(', ')', '_', '-', ' ', "'")
$replacement = ''

# MODES:
# 
# 1 - first and last 4 chars
# 2 = first 8 chars

$mode = 2

# CAPITALIZE OUTPUT:
#
# 0 - leave as is
# 1 - capitalize both name and extension

$capitalize = 1

if ($inputFolder -eq $outputFolder) {

    Write-Error 'Input and output folder are the same.' -ErrorAction Stop

}

$files = Get-ChildItem $inputFolder

for ($i=0; $i -lt $files.Count; $i++) {

    $fullName = $files[$i].FullName
    $name = $files[$i].BaseName
    $ext = $files[$i].Extension
    
    if ($capitalize -eq 1) {
        $name = $name.ToUpper()
        $ext = $ext.ToUpper()
    }

    for ($j = 0; $j -lt $disallowed.Count; $j++) {
        $name = $name.replace($disallowed[$j], $replacement)
    }

    $len = $name.length

    if ($len -gt 8) {

        if ($mode -eq 1) {

            $in = $fullName
            $outfile = $name.substring(0, 4) + $name.substring($len - 4, 4) + $ext
            $dest = $outputFolder + $outfile

        } else {

            $outfile = $name.substring(0, 8) + $ext

        }

        $in = $fullName
        $dest = $outputFolder + $outfile

    } else {
        
        $dest = $outputFolder + $name + $ext

    }

    $in = $fullName
    Copy-Item $in -Destination $dest

}
