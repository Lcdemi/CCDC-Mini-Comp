@echo off
:: Enable Windows Firewall for all profiles
netsh advfirewall set allprofiles state on

:: Set default policy to block all inbound and outbound traffic
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound

:: Allow DNS (UDP 53) - Inbound and Outbound
netsh advfirewall firewall add rule name="Allow DNS-In" dir=in action=allow protocol=UDP localport=53
netsh advfirewall firewall add rule name="Allow DNS-Out" dir=out action=allow protocol=UDP localport=53

:: Allow WinRM (HTTP/HTTPS) - Inbound and Outbound
netsh advfirewall firewall add rule name="Allow WinRM HTTP-In" dir=in action=allow protocol=TCP localport=5985
netsh advfirewall firewall add rule name="Allow WinRM HTTP-Out" dir=out action=allow protocol=TCP localport=5985
netsh advfirewall firewall add rule name="Allow WinRM HTTPS-In" dir=in action=allow protocol=TCP localport=5986
netsh advfirewall firewall add rule name="Allow WinRM HTTPS-Out" dir=out action=allow protocol=TCP localport=5986

:: Allow ICMP (Ping) - Inbound and Outbound
netsh advfirewall firewall add rule name="Allow ICMPv4-In" dir=in action=allow protocol=icmpv4
netsh advfirewall firewall add rule name="Allow ICMPv4-Out" dir=out action=allow protocol=icmpv4
netsh advfirewall firewall add rule name="Allow ICMPv6-In" dir=in action=allow protocol=icmpv6
netsh advfirewall firewall add rule name="Allow ICMPv6-Out" dir=out action=allow protocol=icmpv6

:: Allow Active Directory (LDAP, LDAPS, Kerberos, Global Catalog) - Inbound and Outbound
netsh advfirewall firewall add rule name="Allow LDAP-In" dir=in action=allow protocol=TCP localport=389
netsh advfirewall firewall add rule name="Allow LDAP-Out" dir=out action=allow protocol=TCP localport=389
netsh advfirewall firewall add rule name="Allow LDAPS-In" dir=in action=allow protocol=TCP localport=636
netsh advfirewall firewall add rule name="Allow LDAPS-Out" dir=out action=allow protocol=TCP localport=636
netsh advfirewall firewall add rule name="Allow Kerberos-In" dir=in action=allow protocol=TCP localport=88
netsh advfirewall firewall add rule name="Allow Kerberos-Out" dir=out action=allow protocol=TCP localport=88
netsh advfirewall firewall add rule name="Allow Global Catalog-In" dir=in action=allow protocol=TCP localport=3268
netsh advfirewall firewall add rule name="Allow Global Catalog-Out" dir=out action=allow protocol=TCP localport=3268
netsh advfirewall firewall add rule name="Allow Global Catalog Secure-In" dir=in action=allow protocol=TCP localport=3269
netsh advfirewall firewall add rule name="Allow Global Catalog Secure-Out" dir=out action=allow protocol=TCP localport=3269

:: Allow SMB (File Sharing) - Inbound and Outbound
netsh advfirewall firewall add rule name="Allow SMB-In" dir=in action=allow protocol=TCP localport=445
netsh advfirewall firewall add rule name="Allow SMB-Out" dir=out action=allow protocol=TCP localport=445
netsh advfirewall firewall add rule name="Allow NetBIOS Name Service-In" dir=in action=allow protocol=UDP localport=137
netsh advfirewall firewall add rule name="Allow NetBIOS Name Service-Out" dir=out action=allow protocol=UDP localport=137
netsh advfirewall firewall add rule name="Allow NetBIOS Datagram-In" dir=in action=allow protocol=UDP localport=138
netsh advfirewall firewall add rule name="Allow NetBIOS Datagram-Out" dir=out action=allow protocol=UDP localport=138

:: Allow IIS (HTTP/HTTPS) - Inbound and Outbound
netsh advfirewall firewall add rule name="Allow IIS HTTP-In" dir=in action=allow protocol=TCP localport=80
netsh advfirewall firewall add rule name="Allow IIS HTTP-Out" dir=out action=allow protocol=TCP localport=80
netsh advfirewall firewall add rule name="Allow IIS HTTPS-In" dir=in action=allow protocol=TCP localport=443
netsh advfirewall firewall add rule name="Allow IIS HTTPS-Out" dir=out action=allow protocol=TCP localport=443