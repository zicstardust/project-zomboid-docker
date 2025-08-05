. $PSScriptRoot/functions.ps1
$mods_dir = "/mods"
$server_ini_file = "/server.ini"



$workshop_ids = (IniToHashTable -IniFile $server_ini_file)["WorkshopItems"] -split ";"

foreach ($item in $workshop_ids) {
    Start-Process -FilePath "/app/steamcmd.sh" -ArgumentList "+login anonymous +workshop_download_item 108600 $item +quit" -Wait
}


$mods_downloaded = (Resolve-Path "/home/steam/Steam/steamapps/workshop/content/108600/*/mods/*").Path

foreach ($mod in $mods_downloaded) {
    Copy-Item -Path "$mod" -Destination "$mods_dir" -Recurse -Force
}


$mod_ids = ""
$mods = (Resolve-Path "/mods/*/mod.info").Path


foreach ($item in $mods) {
    $mod_ids = $mod_ids + (IniToHashTable -IniFile $item)["id"] + ";"
}


write-host ""
write-host "Mods=$($mod_ids.Substring(0, $mod_ids.Length - 1))"
write-host ""
