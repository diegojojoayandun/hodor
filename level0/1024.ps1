#=======================================
#= 0. Level 0 - Holberton Hodor Project
#========================================

# ---------------------------------------
# script that votes 1024 times for your id
# here: http://158.69.76.135/level0.php.
# Using WebRequest session (POST)
#-----------------------------------------

$url = "http://158.69.76.135/level0.php";

$sVoteData = @'
id=3922
holdthedoor=Submit
'@


$body = ConvertFrom-StringData -StringData $sVoteData
$headers = @{'Content-Type'= 'application/x-www-form-urlencoded';'ContentLength' = 64}

for($i=1; $i -le 1024; $i++){
    $page = Invoke-WebRequest $url -Method 'Post' -Headers $headers -Body $body
    Write-Host "Sendig vote " -NoNewline
    Write-Host $i -NoNewline
    Write-Host ":" -NoNewline
    write-host $page.StatusDescription -ForegroundColor Red
}

Write-Output "Hodor: Succesful Voting"




