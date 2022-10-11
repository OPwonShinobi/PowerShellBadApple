# PowerShellBadApple
A powershell script that plays an ascii version of Bad Apple while the bad apple mp3 plays in the background.

There's some timing issues, good enough for a weekend project.

Run play.ps1, change the script to $sound_on=$false if you want it on mute.

## Troubleshooting
The script runs on most systems I tested. Some systems may throws this error
"play.ps1 cannot be loaded because running scripts is disabled on this system. ..."

Need to run this from inside the project
`powershell -ExecutionPolicy Bypass -File play.ps1`