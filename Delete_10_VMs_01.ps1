# Define parameters
$VMNamePrefix = "PCXLab_VM_"       # Prefix for VM names
$VMCount = 10                      # Number of VMs to delete
$VHDXPath = "C:\HyperV\VHDs"       # Path where the VHDX files are stored

# Loop to delete VMs
for ($i = 1; $i -le $VMCount; $i++) {
    $VMName = "$VMNamePrefix$i"

    # Check if the VM exists
    $VM = Get-VM -Name $VMName -ErrorAction SilentlyContinue

    if ($VM) {
        # Stop the VM if it's running
        if ($VM.State -eq "Running") {
            Stop-VM -Name $VMName -Force
            Write-Output "Stopped VM: $VMName"
        }

        # Remove the VM
        Remove-VM -Name $VMName -Force
        Write-Output "Deleted VM: $VMName"
    } else {
        Write-Output "VM not found: $VMName"
    }

    # Construct the path to the VHDX file
    $VHDXFile = "$VHDXPath\$VMName.vhdx"

    # Check if the VHDX file exists and delete it
    if (Test-Path $VHDXFile) {
        Remove-Item $VHDXFile -Force
        Write-Output "Deleted VHDX file: $VHDXFile"
    } else {
        Write-Output "VHDX file not found: $VHDXFile"
    }
}

Write-Output "Finished deleting $VMCount virtual machines and their VHDX files."
