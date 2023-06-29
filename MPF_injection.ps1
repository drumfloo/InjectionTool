
function FindFiles {

    #instantiate and opens the FolderBrowserDialog
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = $initialDirectory #"C:\"
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select a directory"

    if($browse.ShowDialog() -eq "OK")
    {
        #User selected Path
        $inputPath += $browse.SelectedPath

        # gets the child elements from the folder selected if suffix is correct
        # *.MPF is the file ending the script will search, you may change that. 
        $MPFfiles = Get-ChildItem -Path $inputPath -include *.MPF -Depth(1) #-Recurse

        #Setup for Progressbar
        $CurrentFile = 0
        $PercentComplete = 0

        #Converter loop
        foreach($singleFile in $MPFfiles)
        {
            #Progressbar-------------------------------------------------------------
            $CurrentFile++
            $PercentComplete = [int](($CurrentFile / $MPFfiles.Count)*100)
            Write-Progress -Activity "Working...." -Status "$PercentComplete% Complete:" -PercentComplete $PercentComplete
            Start-Sleep -Milliseconds 500
            #------------------------------------------------------------------------

            $fileNameNOextensions = [System.IO.Path]::GetFileNameWithoutExtension($singleFile)
            $header = '%_N_' + $fileNameNOextensions + '_MPF' # what needs to be added
            
            @($header) + (Get-Content $singleFile) | Set-Content $singleFile

        }
    }
    $browse.SelectedPath
    $browse.Dispose()
}
FindFiles



