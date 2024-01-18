environmentName="dev"
layerName="01_sql"
location="eastus"

resourceGroups=$(az group list --tag "GeneratedBy=symphony" --tag "EnvironmentName=${environmentName}" --tag "LayerName=${layerName}" --query "[?location=='${location}']" --output json |jq -c -r '.[].name')
echo ${resourceGroups}

for resourceGroup in ${resourceGroups}; do
    echo "Resource group=${resourceGroup}"
    # deployments=$(az deployment group list --resource-group ${resourceGroup} --output json |jq -c -r '.[].name')
    
    
    # # echo "Destroying resource group: ${resourceGroup}"
    # # az group delete --resource-group "${resourceGroup}" --yes
    # exit_code=$?
    echo "Resource group destroyed: ${resourceGroup}"

done

deployments=$(az deployment sub list --query "[?tag=='GeneratedBy=symphony']" --query "[?tag=='EnvironmentName=${environmentName}']" --query "[?tag=='LayerName=${layerName}']" --query "[?location=='${location}']" --output json |jq -c -r '.[].name')
for deployment in ${deployments}; do
    echo "Deleting deployment : ${deployment}"
    # az deployment delete --name "${deployment}"
    exit_code=$?
done
