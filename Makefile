VERSION := 0.3

all:

all:

version:
	echo $(VERSION)

build/ipxe/var/lib/tftpboot/ipxe:
	$(MAKE) -C ipxe
	mkdir -p build/ipxe/var/lib/tftpboot
	cp ipxe/bin/* build/ipxe/var/lib/tftpboot

ubuntu-pxe:
	mkdir -p os-bases/ubuntu/var/www/static/pxe/ubuntu-installer
	[ -f os-bases/ubuntu/var/www/static/pxe/ubuntu-installer/initrd ] || wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/initrd.gz -O os-bases/ubuntu/var/www/static/pxe/ubuntu-installer/initrd
	[ -f os-bases/ubuntu/var/www/static/pxe/ubuntu-installer/vmlinuz ] || wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/linux -O os-bases/ubuntu/var/www/static/pxe/ubuntu-installer/vmlinuz
	touch ubuntu-pxe

centos-pxe:
	mkdir -p os-bases/centos/var/www/static/pxe/centos-installer
	[ -f centos7.iso ] || wget http://mirrors.xmission.com/centos/7.6.1810/isos/x86_64/CentOS-7-x86_64-Minimal-1810.iso -O centos7.iso
	[ -f centos6.iso ] || wget http://mirrors.xmission.com/centos/6.10/isos/x86_64/CentOS-6.10-x86_64-minimal.iso -O centos6.iso
	xorriso -osirrox on -indev centos6.iso -extract_single images/pxeboot/initrd.img os-bases/centos/var/www/static/pxe/centos-installer/6initrd
	xorriso -osirrox on -indev centos6.iso -extract_single images/pxeboot/vmlinuz os-bases/centos/var/www/static/pxe/centos-installer/6vmlinuz
	xorriso -osirrox on -indev centos7.iso -extract_single images/pxeboot/initrd.img os-bases/centos/var/www/static/pxe/centos-installer/7initrd
	xorriso -osirrox on -indev centos7.iso -extract_single images/pxeboot/vmlinuz os-bases/centos/var/www/static/pxe/centos-installer/7vmlinuz
	touch centos-pxe

esx-pxe:
	mkdir -p vmware/vmware/var/www/static/pxe/esx-installer
	if [ -f VMware-VMvisor-Installer-*.iso ]; then ./esxExtractISO VMware-VMvisor-Installer-*.iso vmware/vmware/var/www/static/pxe/esx-installer; fi
	touch esx-pxe

vcenter-ova:
	mkdir -p vmware/vmware/var/www/static/pxe/vmware
	if [ -f VMware-VCSA-*.iso ]; then \
	FILE_NAME=$$( xorriso -osirrox on -indev VMware-VCSA-*.iso -lsl vcsa | grep ova | awk '{print $$9}' | tr -d \' ); \
	xorriso -osirrox on -indev VMware-VCSA-*.iso -extract_single vcsa/$$FILE_NAME vmware/vmware/var/www/static/pxe/vmware/vca.ova 2> /dev/null; \
	fi
	touch vcenter-ova

clean:
	$(MAKE) -C ipxe clean
	$(RM) -r build
	$(RM) *.respkg
	$(RM) ubuntu-pxe
	$(RM) centos-pxe
	$(RM) esx-pxe
	$(RM) vcenter-ova
	$(RM) respkg

dist-clean: clean
	$(MAKE) -C ipxe dist-clean
	$(RM) -r os-bases/ubuntu/var
	$(RM) -r os-bases/centos/var
	$(RM) -r vmware/vmware/var
	$(RM) centos6.iso centos7.iso

.PHONY:: all version clean dist-clean

respkg-distros:
	echo xenial

respkg-requires:
	echo respkg build-essential liblzma-dev xorriso

respkg: ubuntu-pxe centos-pxe esx-pxe vcenter-ova build/ipxe/var/lib/tftpboot/ipxe
	cd os-bases && respkg -b ../contractor-os-base_$(VERSION).respkg     -n contractor-os-base     -e $(VERSION) -c "Contractor - OS Base"               -t load_os_base.sh -d os_base
	cd os-bases && respkg -b ../contractor-ubuntu-base_$(VERSION).respkg -n contractor-ubuntu-base -e $(VERSION) -c "Contractor - Ubuntu Base"           -t load_ubuntu.sh  -d ubuntu -s contractor-os-base
	cd os-bases && respkg -b ../contractor-centos-base_$(VERSION).respkg -n contractor-centos-base -e $(VERSION) -c "Contractor - CentOS Base"           -t load_centos.sh  -d centos -s contractor-os-base
	cd vmware && respkg -b ../contractor-vmware-base_$(VERSION).respkg   -n contractor-vmware-base -e $(VERSION) -c "Contractor - VMware Base"           -t load_vmware.sh  -d vmware -s contractor-os-base -s contractor-plugins-vcenter
	cd build && respkg -b ../contractor-ipxe_$(VERSION).respkg           -n contractor-ipxe        -e $(VERSION) -c "Contractor - iPXE - Netboot loader" -y -d ipxe
	touch respkg

respkg-file:
	echo $(shell ls *.respkg)

.PHONY:: respkg-distros respkg-requires respkg respkg-file

