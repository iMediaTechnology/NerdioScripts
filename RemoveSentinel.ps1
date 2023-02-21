# REMOVE SENTINEL ONE FROM ALL AVD HOSTS PER ACCOUNT
# PARAMETERS:
# SessionHostPrefix = AVD host prefix to search for
# S1APIToken = Sentinel One Service User API Token for Auth

Clear-Host

#Set up endpoint data for requests and REST params
$authHeader = "ApiToken " + $SecureVars.S1APIToken
$headers = @{
    "Authorization" = $authHeader
}
Write-Output "Header Used: " + $authHeader
$agentURL = "https://usea1-pax8-exsp.sentinelone.net/web/api/v2.1/agents?computerName__contains="
$uninstallURL = "https://usea1-pax8-exsp.sentinelone.net/web/api/v2.1/agents/actions/uninstall"
$combinedUri = $agentURL + $SecureVars.SessionHostPrefix

#Make REST GET call to retrieve IDs of endpoints
$dataResponse = Invoke-RestMethod `
    -Verbose `
    -Method 'GET' `
    -Uri $combinedUri `
    -Headers $headers 

#Filter down to IDs of found endpoints and create count var
$rawResult = $dataResponse.data.id
$resultLength = $rawResult.Count


#Format list of endpoint IDs for JSON call
$agentIDs = "["

for ($i = 0; $i -lt $resultLength; $i++)
{
    if ($i -gt 0) { $agentIDs += ", "}
    $agentIDs += @($rawResult)[$i]
}
$agentIDs += "]"

Write-Output "S1 Agent IDs: " $agentIDs

#Create JSON Body for Uninstall
$bodyJSON = @"
{
	"filter": {
		"ids": $agentIDs
	}
}
"@

#Make REST POST call to uninstall endpoint(s) found above
$deleteResponse = Invoke-RestMethod `
    -Verbose `
    -Method 'POST' `
    -Uri $uninstallURL `
    -Headers $headers `
    -ContentType 'application/json' `
    -Body $bodyJSON

Write-Output "Endpoints Uninstalled: " $deleteResponse.data.affected
