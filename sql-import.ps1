         #sql import

$user = 'eswar'
$pass = ConvertTo-SecureString "HAPPYboy@123" -AsPlainText  -Force
$stgaccesskey = Get-AzStorageAccountKey -ResourceGroupName ev-log-rg -Name stgaccev156

New-AzSqlDatabaseImport -DatabaseName sql-database-ev-303 -ServerName sql-server-ev-156 -Edition Basic -DatabaseMaxSizeBytes 2GB -StorageKeyType StorageAccessKey  -StorageKey $stgaccesskey.Value[0] -StorageUri 'https://stgaccev156.blob.core.windows.net/backkuppp/sql-database-ev-156-2021-10-27-14-12.bacpac' -AdministratorLogin $user -AdministratorLoginPassword $pass -ResourceGroupName ev-log-rg -ServiceObjectiveName Basic -AuthenticationType None
