gci C:\Projects *.config -recurse | ForEach {
  (Get-Content $_ | ForEach {$_ -replace "old", "new"}) | Set-Content $_ 
}
