Initialize-Disk -Number 2 -PartitionStyle MBR -PassThru
New-Partition -DiskNumber 2 -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel “disk2” -Confirm:$false
