$response = Invoke-WebRequest -Uri 'https://data.sfgov.org/api/views/rqzj-sfat/rows.csv' -Method GET
$dataTable = ConvertFrom-Csv $response.Content
$filteredData = $dataTable | Where-Object { $_.Status -eq "APPROVED" }
$selectedData = $filteredData | Select-Object Applicant, LocationDescription, FacilityType
$groupedData = $selectedData | Group-Object Applicant, LocationDescription, FacilityType
$uniqueRows = $groupedData | Foreach-Object { $_.Group[0] }
$uniqueRows | Format-Table -AutoSize