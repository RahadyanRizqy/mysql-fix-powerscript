Rename-Item data data-old
New-Item -ItemType Directory data
$backups = Get-ChildItem backup
foreach ($backup in $backups) {
	Copy-Item -Path $backup.FullName -Destination data -ErrorAction Stop
}
$exclusions = @("mysql", "performance_schema", "phpmyadmin", "ibdata1")
$dataolds = Get-ChildItem data-old
$itemsToMove = $dataolds | Where-Object { $exclusions -notcontains $_.Name }
foreach ($item in $itemsToMove) {
	Copy-Item -Path $item.FullName -Destination data -Force -ErrorAction Stop
}
Copy-Item -Path data-old/ibdata1 -D data -Force
