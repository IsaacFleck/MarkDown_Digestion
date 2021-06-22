Function DigestMarkdown (){
    $scripts = @{}
    $md = ConvertFrom-Markdown -Path .\Readme.md 
    $md.Html | Out-File -Encoding utf8 $tempfile

    foreach ($line in Get-Content $tempfile){
        if ($line.StartsWith('<tr>')){
            $t = 1            
        }
        else{
            if ($line.StartsWith('<td>')){
                $n += 1
                if ($t -eq 1){
                    $clean = $line -replace '<[^>]+>',''
                }             
                if ($n -eq 1){
                    $kv = $clean
                }
                else {
                   $scripts.$kv = ($clean, 0) 
                }                
            }
        else {
            $t = 0
            $n = 0
            $kv = ''
        }
        }        
    }
    return $scripts    
}