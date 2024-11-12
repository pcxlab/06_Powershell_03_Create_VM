New-VM -Name "PCXLab_VM_One" -MemoryStartupBytes 2GB -Path "C:\HyperV\VMs" -NewVHDPath "C:\HyperV\VMs\PCXLab_VM_One.vhdx" -NewVHDSizeBytes 60GB -Generation 2 -SwitchName "Default Switch" | Start-VM



Stop-VM -Name "PCXLab_VM_One" -Force
Remove-VM -Name "PCXLab_VM_One" -Force



New-VM -Name "PCXLab_VM_One" -MemoryStartupBytes 2GB -Path "C:\HyperV\VMs" -NewVHDPath "C:\HyperV\VMs\PCXLab_VM_One.vhdx" -NewVHDSizeBytes 100GB -Generation 2 -SwitchName "Default Switch" # | Start-VM

