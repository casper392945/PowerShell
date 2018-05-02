$configFiles = Get-ChildItem . *.config -rec
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -replace "Dev", "Demo" } |
    Set-Content $file.PSPath
}
