

# The idea is to watch your mouse, 
# and if it stays in the same place for more than a minute, 
# and nothing is in full screen mode, start a prompt and start 
# typing in it


Add-Type -AssemblyName System.Windows.Forms | Out-Null

function Get-Position {
    $Pos = [System.Windows.Forms.Cursor]::Position
    $current_position = @($Pos.X, $Pos.Y)
    $current_position
}

function Compare-Position {
    $position_one = $args[0]
    $position_two = $args[1]
    $return_value = $false

    if($position_one[0] -eq $position_two[0] -and $position_one[1] -eq $position_two[1]){
        $return_value = $true
    }
    $return_value
}

function LookingBusy {
    if($process_id -eq 0){
        $Process = [Diagnostics.Process]::Start("notepad")          
        $Process.Id 
    }else{
        $process_id
    }
}

function stopLookingBusy{
    try {            
        Stop-Process -Id $process_id -ErrorAction stop            
        Write-Host "Successfully killed the process with ID: $process_id"           
    } catch {            
        Write-Host "Failed to kill the process" 
    }
    $process_id = 0
    $process_id
}

$wait_time_before_prompt = 5
$process_id = 0

$last_position = @(0,0)

while ($true)
{
    $last_position = Get-Position
    Write-Host "Waiting"
    Start-Sleep -Seconds $wait_time_before_prompt
    $current_position = Get-Position

    if(Compare-Position $last_position $current_position ){
        Write-Host "Mouse not moving"
        
        $process_id = LookingBusy
        Write-Host $process_id
    } else{
        Write-Host "Mouse IS moving"
        $process_id = stopLookingBusy
        Write-Host $process_id
    }
    
}




# $Process = [Diagnostics.Process]::Start("notepad")          
# $id = $Process.Id            
# Write-Host "Process created. Process id is $id"            
# Write-Host "sleeping for 5 seconds"            
# Start-Sleep -Seconds 5
# try {            
#     Stop-Process -Id $id -ErrorAction stop            
#     Write-Host "Successfully killed the process with ID: $ID"            
# } catch {            
#     Write-Host "Failed to kill the process" 
# }


