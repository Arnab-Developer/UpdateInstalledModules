class PowerShellModuleUtility
{
    hidden [string] $ModuleName

    PowerShellModuleUtility([string] $ModuleName)
    {
        $this.ModuleName = $ModuleName
    }

    [bool] IsModuleUpdated()
    {
        $repositoryModule = Find-Module -Name $this.ModuleName
        $installedModule = Get-InstalledModule -Name $this.ModuleName
        return $installedModule.Version -eq $repositoryModule.Version
    }

    [void] UpdateModule()
    {
        Update-Module -Name $this.ModuleName
    }
}

$installedModules = Get-InstalledModule
foreach($installedModule in $installedModules)
{
    $utility = [PowerShellModuleUtility]::new($installedModule.Name)
    if($utility.IsModuleUpdated() -eq $true)
    {
        Write-Host "Already updated:" $installedModule.Name        
    }
    else
    {
        $utility.UpdateModule()
        Write-Host "Updated:" $installedModule.Name
    }
}