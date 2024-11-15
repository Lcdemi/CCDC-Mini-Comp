# Set the execution policy temporarily to unrestricted to allow this script to run
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

# Retrieve current SMB server settings for review
Get-SmbServerConfiguration | Format-List
Write-Output "Current SMB Server Configuration retrieved for review."

# Disable SMB1 protocol (outdated and insecure) and ensure SMB2/3 are enabled for enhanced security.
# Enforce SMB signing to prevent man-in-the-middle attacks and reject unencrypted access.
Set-SmbServerConfiguration -EnableSMB1Protocol $false -EnableSMB2Protocol $true -EnableSecuritySignature $true -RequireSecuritySignature $true -RejectUnencryptedAccess $true -Force
Write-Output "SMB1 Protocol Disabled. SMB2 Protocol Enabled. SMB signing and encryption enforced."

# Disable the Guest account to prevent unauthenticated access via SMB.
# Disable null session shares and pipes to further restrict anonymous access.
Get-LocalUser -Name "Guest" | Disable-LocalUser
Set-SmbServerConfiguration -NullSessionShares "" -NullSessionPipes "" -Force
Write-Output "Guest account disabled. Null sessions and anonymous access restrictions applied."

# Enforce data encryption to secure SMB traffic and set an idle session timeout for automatic disconnections.
Set-SmbServerConfiguration -EncryptData $true -AutoDisconnectTimeout 10 -Force
Write-Output "SMB data encryption enabled and idle session timeout set to 10 minutes."

# Disable multi-channel and leasing, which can increase the attack surface if not required.
Set-SmbServerConfiguration -EnableMultiChannel $false -EnableLeasing $false -Force
Write-Output "Multi-channel and leasing disabled to reduce attack surface."

# Enable strict name checking to enforce valid connection names for enhanced security.
Set-SmbServerConfiguration -EnableStrictNameChecking $true -Force
Write-Output "Strict name checking enabled to prevent invalid connection names."

# Check and list all SMB shares on the server to assess for potential security risks.
Get-SmbShare | Format-List
Write-Output "SMB Shares listed for review of access and permissions."

# Configure client-side SMB settings for security.
# Enforce security signatures and disable multi-channel from the client side.
Set-SmbClientConfiguration -EnableSecuritySignature $true -RequireSecuritySignature $true -EnableMultiChannel $false -Force
Write-Output "Client-side SMB configuration applied with enforced signing and disabled multi-channel."

# Monitor active SMB sessions to detect unauthorized or excessive connections.
Get-SmbSession | Format-Table -Property ClientComputerName, UserName, SessionId
Write-Output "Active SMB sessions listed for monitoring purposes."

# End a suspicious or unwanted SMB session by specifying its Session ID (example below).
# Close-SmbSession -SessionId <SessionID>
# Write-Output "Use Close-SmbSession -SessionId <SessionID> to terminate any suspicious session."

# List all active SMB connections from the client side for monitoring purposes.
Get-SmbConnection | Format-Table -Property ServerName, ShareName, UserName
Write-Output "Active SMB client connections retrieved for review."

# Fully disable SMB1 if it is still enabled, as it is outdated and insecure.
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
Write-Output "SMB1 Protocol disabled completely."

# Reinstate the execution policy to restricted after running the script
Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope Process
Write-Output "Execution policy set back to Restricted."