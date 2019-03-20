function Get-FolderPermissions {
    [CmdletBinding()]
    param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    $filePath = "C:\",

    # Parameter help description
    [Parameter(Mandatory=$true)]
    $outputCSV = "C:\temp\PermissionOutput.csv"

    )

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
    $folderAcl | Export-Csv $outputCSV


}


