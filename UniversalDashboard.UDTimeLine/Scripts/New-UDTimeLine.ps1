<#
.SYNOPSIS
    Sample control for UniversalDashboard.
.DESCRIPTION
    Sample control function for UniversalDashboard. This function must have an ID and return a hash table.
.PARAMETER Id
    An id for the component default value will be generated by new-guid.
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function New-UDTimeLine {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),

        [Parameter()]
        [string]$Width = "100%",

        [Parameter()]
        [string]$Height,

        [Parameter()]
        [scriptblock]$Data,

        [Parameter()]
        [object]$OnClick,

        [Parameter()]
        [bool]$ShowRowLabels,

        [Parameter()]
        [bool]$ShowRowNumber,

        [Parameter()]
        [bool]$GroupByRowLabel,

        [Parameter()]
        [bool]$ColorByRowLabel,

        [Parameter()]
        [string]$BackgroundColor,

        [Parameter()]
        [string]$FontName,

        [Parameter()]
        [int]$FontSize,

        [Parameter()]
        [string]$FontColor
    )

    End {
        if ($null -ne $OnClick) {
            if ($OnClick -is [scriptblock]) {
                $OnClick = New-UDEndpoint -Endpoint $OnClick -Id ($Id + "onClick")
            }
            elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnClick must be a script block or UDEndpoint"
            }
        }

        [System.Collections.ArrayList]$MainData = @()
        [array]$RawData = [array]$Data.Invoke()
        foreach ($Item in $RawData) {
            [System.Collections.ArrayList]$ItemData = @(
                $Item.RowLabel
                $Item.BarLabel
                $Item.ToolTip

                #https://developers.google.com/chart/interactive/docs/datesandtimes#dates-and-times-using-the-date-string-representation
                #Important: When using this Date String Representation, as when using the new Date() constructor, months are indexed starting at zero (January is month 0, December is month 11).
                "Date($($Item.Start.Year), $($Item.Start.Month - 1), $($Item.Start.Day), $($Item.Start.Hour), $($Item.Start.Minute), $($Item.Start.Second), $($Item.Start.Millisecond))"
                "Date($($Item.End.Year), $($Item.End.Month - 1), $($Item.End.Day), $($Item.End.Hour), $($Item.End.Minute), $($Item.End.Second), $($Item.End.Millisecond))"
            )
            $MainData.Add($ItemData) | Out-Null
        }

        [array]$Colors = $null
        [array]$DataColors = $RawData.Color | ? { $_ }
        if ($DataColors) {
            if (@($DataColors).Count -ne (@($RawData).Count)) {
                throw 'color is not defined in all data items.'
            }
            [array]$Colors = @($DataColors)
        }

        $Component = @{
            # The AssetID of the main JS File
            assetId  = $AssetId
            # Tell UD this is a plugin
            isPlugin = $true
            # This ID must be the same as the one used in the JavaScript to register the control with UD
            type     = "UD-TimeLine"
            # An ID is mandatory
            id       = $Id
            onClick  = $OnClick

            # This is where you can put any other properties. They are passed to the React control's props
            # The keys are case-sensitive in JS.
            width    = $Width
            height   = $Height
            data     = $MainData
        }
        if ($PSBoundParameters.ContainsKey('ShowRowLabels')) { $Component.showRowLabels = $ShowRowLabels }
        if ($PSBoundParameters.ContainsKey('showRowNumber')) { $Component.showRowNumber = $ShowRowNumber }
        if ($PSBoundParameters.ContainsKey('GroupByRowLabel')) { $Component.groupByRowLabel = $GroupByRowLabel }
        if ($PSBoundParameters.ContainsKey('ColorByRowLabel')) { $Component.colorByRowLabel = $ColorByRowLabel }
        if ($PSBoundParameters.ContainsKey('BackgroundColor')) { $Component.backgroundColor = $BackgroundColor }
        if ($Colors) { $Component.colors = $Colors }
        if ($PSBoundParameters.ContainsKey('FontColor')) { $Component.color = $FontColor }
        if ($PSBoundParameters.ContainsKey('FontName')) { $Component.fontName = $FontName }
        if ($PSBoundParameters.ContainsKey('FontSize')) { $Component.fontSize = $FontSize }

        $Component
    }
}
