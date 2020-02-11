# UDTimeLine
Google TimeLine component for UD

## Demo
```
Import-Module -Name universaldashboard.Community -RequiredVersion 2.8.1
Import-Module "C:\ud\TimeLine\src\output\UniversalDashboard.UDTimeLine\UniversalDashboard.UDTimeLine.psd1"
Get-UDDashboard | Stop-UDDashboard
$theme = New-UDTheme -Name 'Basic' -Definition @{
    'main' = @{
        'padding-left'   = '5px'
        'padding-right'  = '5px'
        'padding-top'    = '5px'
        'padding-bottom' = '5px'
    }
} -Parent 'Default'
Start-UDDashboard -Port 1000 -AutoReload -Dashboard (
    New-UDDashboard -Title 'Powershell UniversalDashboard' -Content {
        New-UDCard -Content {
            New-UDHeading -Text 'Simple Example' -Size 3
            New-UDTimeLine -Id 'Timeline_Simple' -Data {
                New-UDTimeLineData -RowLabel "Washington" -Start (Get-Date -Year 1789 -Month 4 -Day 30) -End (Get-Date -Year 1797 -Month 3 -Day 4)
                New-UDTimeLineData -RowLabel "Adams" -Start (Get-Date -Year 1797 -Month 3 -Day 4) -End (Get-Date -Year 1801 -Month 3 -Day 4)
                New-UDTimeLineData -RowLabel "Jefferson" -Start (Get-Date -Year 1801 -Month 3 -Day 4) -End (Get-Date -Year 1809 -Month 3 -Day 4)
            }

            New-UDHeading -Text 'Colour Grid Option Example' -Size 3
            New-UDTimeLine -Id 'Timeline_Option' -Data {
                New-UDTimeLineData -RowLabel "Task1" -Start (Get-Date).AddMilliseconds(-34534) -End (Get-Date)
                New-UDTimeLineData -RowLabel "Task2" -Start (Get-Date).AddSeconds(-34) -End (Get-Date)
                New-UDTimeLineData -RowLabel "Task3" -Start (Get-Date).AddMinutes(-3) -End (Get-Date)
            } -ShowRowLabels $true -ShowRowNumber $false -GroupByRowLabel $false -ColorByRowLabel $true -BackgroundColor "#ffd" -FontName "Garamond" -FontSize 20 -FontColor "#000"

            New-UDHeading -Text 'Color Example' -Size 3
            New-UDTimeLine -Id 'Timeline_Color' -Data {
                New-UDTimeLineData -RowLabel "Task1" -Start (Get-Date).AddMilliseconds(-3534) -End (Get-Date) -Color '#95a3b3'
                New-UDTimeLineData -RowLabel "Task2" -Start (Get-Date).AddSeconds(-34) -End (Get-Date) -Color '#f7f06d'
                New-UDTimeLineData -RowLabel "Task3" -Start (Get-Date).AddMinutes(-3) -End (Get-Date) -Color '#6abf0f'
            }

            New-UDHeading -Text 'Bar Label with tooltip Example' -Size 3
            New-UDTimeLine -Id 'Timeline_OnClick' -Data {
                New-UDTimeLineData -RowLabel "Austria" -BarLabel "Austria" -tooltip "Hello from Austria" -Start (Get-Date -Year 1789 -Month 4 -Day 30) -End (Get-Date -Year 1797 -Month 3 -Day 4)
                New-UDTimeLineData -RowLabel "England" -BarLabel "England" -tooltip "Alright mush" -Start (Get-Date -Year 1797 -Month 3 -Day 4) -End (Get-Date -Year 1801 -Month 3 -Day 4)
                New-UDTimeLineData -RowLabel "Norway" -BarLabel "Norway" "Howdie partner" -Start (Get-Date -Year 1801 -Month 3 -Day 4) -End (Get-Date -Year 1809 -Month 3 -Day 4)
            }
        }
    }
)
```
