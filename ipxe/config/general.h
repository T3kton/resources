#ifndef CONFIG_LOCAL_GENERAL_H
#define CONFIG_LOCAL_GENERAL_H

#define NET_PROTO_IPV4
#define NET_PROTO_IPV6
#undef  NET_PROTO_FCOE
#undef  NET_PROTO_STP
#undef  NET_PROTO_LACP

#undef  PXE_STACK
#undef  PXE_MENU

#define DOWNLOAD_PROTO_TFTP
#define DOWNLOAD_PROTO_HTTP
#undef  DOWNLOAD_PROTO_HTTPS
#undef  DOWNLOAD_PROTO_FTP
#undef  DOWNLOAD_PROTO_SLAM
#undef  DOWNLOAD_PROTO_NFS
#undef  DOWNLOAD_PROTO_FILE

#undef  SANBOOT_PROTO_ISCSI
#undef  SANBOOT_PROTO_AOE
#undef  SANBOOT_PROTO_IB_SRP
#undef  SANBOOT_PROTO_FCP
#undef  SANBOOT_PROTO_HTTP

#undef  HTTP_AUTH_BASIC
#undef  HTTP_AUTH_DIGEST

#undef  CRYPTO_80211_WEP
#undef  CRYPTO_80211_WPA
#undef  CRYPTO_80211_WPA2

#define IMAGE_SCRIPT
#undef  IMAGE_NBI
#undef  IMAGE_MULTIBOOT
#undef  IMAGE_BZIMAGE
#undef  IMAGE_COMBOOT
#undef  IMAGE_SDI
#undef  IMAGE_PNM
#undef  IMAGE_PNG
#undef  IMAGE_DER
#undef  IMAGE_PEM

#if(T3KTON_EFI)
#undef  IMAGE_PXE
#define IMAGE_EFI
#undef  IMAGE_ELF

#else
#define IMAGE_PXE
#undef  IMAGE_EFI
#define IMAGE_ELF
#endif /* T3KTON_EFI */

#undef  AUTOBOOT_CMD            /* Automatic booting */
#undef  NVO_CMD                 /* Non-volatile option storage commands */
#define CONFIG_CMD              /* Option configuration console */
#define IFMGMT_CMD              /* Interface management commands */
#undef  IWMGMT_CMD              /* Wireless interface management commands */
#undef  IBMGMT_CMD              /* Infiniband management commands */
#undef  FCMGMT_CMD              /* Fibre Channel management commands */
#define ROUTE_CMD               /* Routing table management commands */
#define IMAGE_CMD               /* Image management commands */
#define DHCP_CMD                /* DHCP management commands */
#define SANBOOT_CMD             /* SAN boot commands */
#undef  MENU_CMD                /* Menu commands */
#undef  LOGIN_CMD               /* Login command */
#undef  SYNC_CMD                /* Sync command */
#define NSLOOKUP_CMD            /* DNS resolving command */
#undef  TIME_CMD                /* Time commands */
#undef  DIGEST_CMD              /* Image crypto digest commands */
#undef  LOTEST_CMD              /* Loopback testing commands */
#define VLAN_CMD                /* VLAN commands */
#undef  PXE_CMD                 /* PXE commands */
#define REBOOT_CMD              /* Reboot command */
#define POWEROFF_CMD            /* Power off command */
#undef  IMAGE_TRUST_CMD         /* Image trust management commands */
#undef  PCI_CMD                 /* PCI commands */
#undef  PARAM_CMD               /* Form parameter commands */
#undef  NEIGHBOUR_CMD           /* Neighbour management commands */
#define PING_CMD                /* Ping command */
#define CONSOLE_CMD             /* Console command */
#define IPSTAT_CMD              /* IP statistics commands */
#undef  PROFSTAT_CMD            /* Profiling commands */
#undef  NTP_CMD                 /* NTP commands */
#undef  CERT_CMD                /* Certificate management commands */


#undef  NONPNP_HOOK_INT19
#undef  AUTOBOOT_ROM_FILTER

#undef  VNIC_IPOIB
#undef  VNIC_XSIGO


#endif /* CONFIG_LOCAL_GENERAL_H */
