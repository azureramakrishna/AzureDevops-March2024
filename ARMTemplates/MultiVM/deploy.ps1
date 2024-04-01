#Connect-AzAccount -TenantId 459865f1-a8aa-450a-baec-8b47a9e5c904

#New-AzResourceGroup -Name 'arm-group' -Location 'eastus'

New-AzResourceGroupDeployment -ResourceGroupName 'arm-group' -TemplateFile ./template.json -TemplateParameterFile ./parameters.json -Verbose