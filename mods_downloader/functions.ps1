function IniToHashTable {
    param (
        [Parameter(Mandatory = $true)]
        [string]$IniFile
    )

    $iniContent = Get-Content $IniFile | Where-Object { $_ -and $_ -notmatch '^\s*;' }
    $iniHashTable = @{}
    foreach ($line in $iniContent) {
        $key, $value = $line -split '=', 2
        $iniHashTable[$key.Trim()] = $value.Trim()
    }
    
    return $iniHashTable
}