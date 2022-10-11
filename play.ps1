#==== CONFIGS_START ===

$fps = 15
$skipNthFrame = 15 # set to 0 if unused
$sound_on = $true
#==== CONFIGS_END ====


#=== setup ===
$ms = 1000/$fps

$filenames = get-childitem -path './frames' | where-object { $_.extension -eq '.txt' }
$frames = $filenames.Count
[console]::TreatControlCAsInput = $true

function checkCtrlC {
    if ([console]::KeyAvailable)
    {
        $key = [system.console]::readkey($true)
        if (($key.modifiers -band [consolemodifiers]"control") -and ($key.key -eq "C"))
        {
            Add-Type -AssemblyName System.Windows.Forms
            return $true
        }
    }
    return $false
}

Add-Type -AssemblyName presentationCore
$mediaPlayer = New-Object system.windows.media.mediaplayer
# media player needs fullpath to work
$bgm_path = (pwd).tostring()+"\bgm.mp3"

#=== logic ===

if ($sound_on) {
    # give it a couple seconds to load mp3
    $mediaPlayer.open($bgm_path)
}

clear
write-host "Mini theatre, ctrl+c to stop video (and) sound"
write-host "`nTotal : "$filenames.Count "frames `n"
Write-Host -NoNewline Starting 3
sleep 1
Write-Host -NoNewline `b2
sleep 1
if ($sound_on) {
    #start sound 1sec early
    $mediaPlayer.play()
}
Write-Host -NoNewline `b1
sleep 1

for ($i = 0 ; $i -lt $frames ; $i++) {
    if (checkCtrlC) {
        $mediaPlayer.Stop()
        break
    }
    # seems to lag ever slightly behind every Nth frame, 2ms delay more or less fixes it
    if ($skipNthFrame -gt 0 -and $i % $skipNthFrame -eq 0) {
        sleep -milliseconds 2
        continue
    }
    type "./frames/$i.txt"
    Write-Host $i/"$frames"
    sleep -milliseconds $ms
    clear
}