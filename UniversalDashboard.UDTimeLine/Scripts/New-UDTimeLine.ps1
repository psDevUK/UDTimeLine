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
        [int]$BarFontSize,

        [Parameter()]
        [string]$FontColor
    )

    End {
        [System.Collections.ArrayList]$MainData = @()
        [array]$RawData = [array]$Data.Invoke()
        foreach ($Item in $RawData) {
            [System.Collections.ArrayList]$ItemData = @(
                $Item.RowLabel
                $Item.BarLabel
                $Item.tooltip
                $Item.Start
                $Item.End
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
        if ($PSBoundParameters.ContainsKey('BarFontSize')) { $Component.barFontSize = $BarFontSize }
        $Component
    }
}

