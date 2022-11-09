resource "azurerm_resource_group" "SQLExample" {
  name     = "SQL-Test-Deployment-${terraform.workspace}"
  location = var.resource_group_location
}

resource "azurerm_mssql_server" "Server" {
  name                   = lower("exampleSQLServer-${terraform.workspace}")
  resource_group_name    = azurerm_resource_group.SQLExample.name
  location               = azurerm_resource_group.SQLExample.location
  version                = "12.0"
  administrator_login     = "Adminadminadmin"
  administrator_login_password = "P@ssword12473467364734673"

  tags = {
    environment = "${terraform.workspace}"
  }
}

resource "azurerm_storage_account" "StorageAccnt" {
  name                     = lower("stgacct${terraform.workspace}")
  resource_group_name      = azurerm_resource_group.SQLExample.name
  location                 = azurerm_resource_group.SQLExample.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_database" "test" {
  name           = "database-${terraform.workspace}"
  server_id      = azurerm_mssql_server.Server.id
}