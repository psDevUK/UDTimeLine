Import-Module UniversalDashboard  -Force
Import-Module "C:\UniversalDashboard\UDTimeLine\UniversalDashboard.UDTimeLine\UniversalDashboard.UDTimeLine.psd1" -Force

Get-UDDashboard | Stop-UDDashboard

Start-UDDashboard -Port 10000 -Dashboard (
    New-UDDashboard -Title 'Powershell UniversalDashboard' -Content {
        New-UDCard -Content {
            New-UDTimeLine -Id 'Timeline' -Data {
                New-UDTimeLineData -RowLabel "Washington" -Start (Get-Date -Year 1789 -Month 4 -Day 30) -End (Get-Date -Year 1797 -Month 3 -Day 4)
                New-UDTimeLineData -RowLabel "Adams" -Start (Get-Date -Year 1797 -Month 3 -Day 4) -End (Get-Date -Year 1801 -Month 3 -Day 4)
                New-UDTimeLineData -RowLabel "Jefferson" -Start (Get-Date -Year 1801 -Month 3 -Day 4) -End (Get-Date -Year 1809 -Month 3 -Day 4)    
            }

            New-UDTimeLine -Id 'Timeline' -Data {
                New-UDTimeLineData -RowLabel "Task1" -Start (Get-Date).AddMilliseconds(-34534) -End (Get-Date)
                New-UDTimeLineData -RowLabel "Task2" -Start (Get-Date).AddSeconds(-34) -End (Get-Date)
                New-UDTimeLineData -RowLabel "Task2" -Start (Get-Date).AddMinutes(-3) -End (Get-Date)
            }
        }
    }
)