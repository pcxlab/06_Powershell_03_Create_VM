# Define parameters
$VMNamePrefix = "PCXLab_VM_"          # Prefix for VM names
$VMCount = 10                         # Number of VMs to create
$VMSwitch = "Default Switch"          # Name of the virtual switch to use
$MemoryStartupBytes = 1GB             # Startup memory for each VM
$VHDXSizeBytes = 100GB                # Size of the virtual hard disk
$VHDXPath = "C:\HyperV\VHDs"          # Path to store the VHDX files
$ISOPath = "C:\LAB_Automation\MyLab\Windows 10 Enterprise ISO\Win10ENT19045.2006.220908-0225.22h2_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"  # Path to the boot ISO file
$VMPath = "C:\HyperV\VMs"            # Path to store the VM configuration files

# Ensure the paths exist
New-Item -Path $VHDXPath -ItemType Directory -Force
New-Item -Path $VMPath -ItemType Directory -Force

# Loop to create VMs
for ($i = 1; $i -le $VMCount; $i++) {
    $VMName = "$VMNamePrefix$i"
    $VHDXFile = "$VHDXPath\$VMName.vhdx"

    # Create a new virtual hard disk for the VM
    New-VHD -Path $VHDXFile -SizeBytes $VHDXSizeBytes -Dynamic

    # Create the new VM
    New-VM -Name $VMName -MemoryStartupBytes $MemoryStartupBytes -VHDPath $VHDXFile -Path $VMPath

    # Add a network adapter and connect it to the virtual switch
    Add-VMNetworkAdapter -VMName $VMName -SwitchName $VMSwitch

    # Set the boot device to the ISO file
    Set-VMDvdDrive -VMName $VMName -Path $ISOPath

    # Start VM
    # Start-VM $VMName

    Write-Output "Created and started VM: $VMName"
}

Write-Output "Finished creating $VMCount virtual machines."
