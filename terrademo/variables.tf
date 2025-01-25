variable "project" {
  description = "Project"
  default     = "utility-cathode-448702-g7"
}


variable "location" {
  description = "Project location"
  default     = "US"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "utility-cathode-448702-g7-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDAR"
}