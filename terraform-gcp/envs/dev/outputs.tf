output "instance_name" { value = module.compute.instance_name }
output "instance_external_ip" { value = module.compute.external_ip }
output "bucket_name" { value = module.storage.bucket_name }
output "service_account_email" { value = module.iam.service_account_email }
