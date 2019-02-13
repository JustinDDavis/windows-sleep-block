
Add-Type -AssemblyName System.Windows.Forms | Out-Null

# Helper Functions
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


# Configuration settings
$wait_time_before_notepad_opens = 15
$process_id = 0
$myshell = New-Object -com "Wscript.Shell"
$last_position = @(0,0)


# Main Process
while ($true)
{
    $last_position = Get-Position
    Write-Host "Waiting to check position" $last_position
    Start-Sleep -Seconds $wait_time_before_notepad_opens
    $current_position = Get-Position

    if(Compare-Position $last_position $current_position ){
        Write-Host "Mouse not moving"
        
        $process_id = LookingBusy
        $myshell.AppActivate('Untitled - Notepad')
        $time = (Get-Date) | Out-String
        $myshell.sendkeys($time)
        Write-Host "Notepad's Process ID: $process_id"
    } else{
        Write-Host "Mouse IS moving, notepad should shutdown if open"
        $process_id = stopLookingBusy
        Write-Host "Notepad's Process ID: $process_id"
    }
    
}


