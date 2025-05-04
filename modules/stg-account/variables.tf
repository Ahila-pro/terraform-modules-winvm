variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string  
  
}
variable "location" {
  description = "The location of the resource group."
  type        = string      
  
}
variable "name" {
  description = "Name of the storage account."
  type        = string
    
  
}

variable "account_tier" {
  description = "The account tier of the storage account."
  type        = string
 
  
}
variable "account_replication_type" {
  description = "The replication type of the storage account."
  type        = string
   
  
}