$exclude = @("*log*", "*bak*")
$files = Get-ChildItem -Path "D:\temp", "c:\temp" -Recurse -exclude $exclude 

foreach ($file in $files){

$find = "Server1"
$replace = "NewServername1"
$content = Get-Content $($file.FullName) -Raw
#write replaced content back to the file
$content -replace $find,$replace | Out-File $($file.FullName) 
}
