provider "azurerm" {
  version = "=2.0.0"
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "SmartQED-RG"
  location = "westus"
}

resource "azurerm_app_service_plan" "main" {
  name                = "ASP-SmartQED"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "wardeploysr"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  app_service_plan_id = "${azurerm_app_service_plan.main.id}"

  site_config {
    linux_fx_version = "TOMCAT|9.0-jre8"
  }
}
