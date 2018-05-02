$filePath = 'c:\work\projects\'
$fileName = 'project.mobirise'

$RecentsList = 'C:\tmp\recents.list'
$date = Get-Date -UFormat '%Y%m%d%H%M%S'
$RecentsListBackup = $RecentsList+'.'+$date
if (Test-Path $RecentsList) { Rename-Item -Path $RecentsList -NewName $RecentsListBackup }

$Dirs=Get-ChildItem -Path $filePath -Recurse | where {$_.Name -like $fileName} | Sort-Object LastWriteTime -Descending | Select-Object Directory

Out-File -FilePath $RecentsList -Encoding ascii -InputObject '[' -Append

foreach( $Dir in $Dirs) {
    $strDir = $Dir.Directory.ToString()
    $project = $strDir+'\project.mobirise'
    $project_name = Get-Content -Path $project | Where-Object {$_.Contains('"name":')}
    $name = $project_name[0].TrimStart().Replace('": "','":"')
    $path ='"path":'+'"file:///'+$strDir.Replace("\","/")+'/"'
    if (Test-Path($strDir+"\screenshot.png")){
        $screenshot = ',"screenshot":"screenshot.png"'
    }
    else
    {
        $screenshot=''
    }
    $str = '{'+$name+$path+$screenshot+'}'
    if ($Dir -ne $Dirs[-1]) { $str = $str+','}
    Out-File -FilePath $RecentsList -Encoding ascii -InputObject $str -Append
}

Out-File -FilePath $RecentsList -Encoding ascii -InputObject ']' -Append
