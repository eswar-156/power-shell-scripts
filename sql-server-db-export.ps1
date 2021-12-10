#create sqlserver and sql database & sqldatabase export & import

$sqlusername = "eswar"
$sqlpassword = ConvertTo-SecureString "HAPPYboy@123" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($sqlusername,$sqlpassword);

        #SQL SERVER

New-AzSqlServer -ResourceGroupName ev-log-rg -Location 'east us' -ServerName sql-server-ev-156 -SqlAdministratorCredentials $cred -Verbose

        #create SQL server/db firewallsettings (allow azure resource )

New-AzSqlServerFirewallRule -ServerName sql-server-ev-156 -FirewallRuleName demorule -ResourceGroupName ev-log-rg -StartIpAddress 0.0.0.0 -EndIpAddress 0.0.0.0 -Verbose

        #SQL DB

New-AzSqlDatabase -ResourceGroupName ev-log-rg -Name sql-database-ev-156 -Edition Basic -BackupStorageRedundancy Geo -ServerName sql-server-ev-156 -verbos

         #Creating Storage Account

$stgacc = New-AzStorageAccount -ResourceGroupNam ev-log-rg -Location 'east us' -Name stgaccev156 -SkuName Standard_LRS -Kind StorageV2 -AccessTier Hot -Verbose
  
          #Create container in Storage Account

$stg = $stgacc.Context

New-AzStorageContainer -Name backkuppp -Context $stg -Permission Blob

         #sql export

$user = 'eswar'
$pass = ConvertTo-SecureString "HAPPYboy@123" -AsPlainText -Force
$stgaccesskey = Get-AzStorageAccountKey -ResourceGroupName ev-log-rg -Name stgaccev156

New-AzSqlDatabaseExport -DatabaseName sql-database-ev-156 -ServerName sql-server-ev-156 -StorageKeyType StorageAccessKey -StorageKey $stgaccesskey.Value[0] -StorageUri 'https://stgaccev156.blob.core.windows.net/backkuppp/sql-database-ev-156-2021-10-27-14-12.bacpac' -AdministratorLogin $user -AdministratorLoginPassword $pass -Verbose -ResourceGroupName ev-log-rg
