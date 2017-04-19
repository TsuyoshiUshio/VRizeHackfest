variable "location" {
}
variable "default_user" {
}
variable "subscription_id" {
}
variable "client_id" {
} variable "client_secret" {
}
variable "tenant_id" {
}
variable "default_password" {
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "prod" {
  name     = "app-builder-tf"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "prod" {
  name                = "vrizevideovn"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.prod.name}"
}

resource "azurerm_subnet" "prod" {
  name                 = "vrizevideosub"
  resource_group_name  = "${azurerm_resource_group.prod.name}"
  virtual_network_name = "${azurerm_virtual_network.prod.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_storage_account" "prod" {
  name                = "rtyhyovrizeasa"
  resource_group_name = "${azurerm_resource_group.prod.name}"
  location            = "${var.location}"
  account_type        = "Standard_LRS"

  tags {
    environment = "prod"
  }
}

resource "azurerm_storage_container" "prod" {
  name                  = "aqwsevhds"
  resource_group_name   = "${azurerm_resource_group.prod.name}"
  storage_account_name  = "${azurerm_storage_account.prod.name}"
  container_access_type = "private"
}

resource "azurerm_virtual_machine_scale_set" "prod" {
  name                = "myprodscaleset-1"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.prod.name}"
  upgrade_policy_mode = "Manual"

  sku {
    name     = "Standard_DS2_v2"
    tier     = "Standard"
    capacity = 2
  }

  os_profile {
    computer_name_prefix = "prodvm"
    admin_username       = "${var.default_user}"
    admin_password       = "${var.default_password}"
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  network_profile {
    name    = "prodNetworkProfile"
    primary = true

    ip_configuration {
      name      = "prodIPConfiguration"
      subnet_id = "${azurerm_subnet.prod.id}"
    }
  }

  storage_profile_os_disk {
    name = "osDiskProfile"
    caching = "ReadWrite"
    create_option  = "FromImage"
  }

  storage_profile_image_reference {
      resource_id = "/subscriptions/c9c75d6e-4f09-4455-88e9-9e6f015f4ed7/resourceGroups/test-unity-build/providers/Microsoft.Compute/images/jenkins_hackfest"
  }
}
