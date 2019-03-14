$sw = [Diagnostics.Stopwatch]::StartNew()
$filePath = "C:\"

$folders = [System.IO.Directory]::EnumerateDirectories($filePath,"*",1)
$folderAcl = @()
foreach($f in $folders){
    $acl = Get-Acl -Path $f
   $folderAcl += New-Object pscustomobject -Property @{
        path = $f
        FileSystemRights = "$($acl.Access.FileSystemRights)"
        AccessControlType = "$($acl.Access.AccessControlType)"
        IdentityReference = "$($acl.Access.IdentityReference)"
        Inherited = "$($acl.Access.IsInherited)"


    }

}
$folderAcl | Export-Csv C:\temp\tem.csv

$sw.Stop()
$sw.Elapsed