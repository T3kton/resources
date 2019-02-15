VERSION := 0.1

version:
	echo $(VERSION)

all:

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
	isoinfo -i centos6.iso -x /IMAGES/PXEBOOT/INITRD.IMG\;1 > os-bases/centos/var/www/static/pxe/centos-installer/6initrd
	isoinfo -i centos6.iso -x /IMAGES/PXEBOOT/VMLINUZ.\;1 > os-bases/centos/var/www/static/pxe/centos-installer/6vmlinuz
	isoinfo -i centos7.iso -x /IMAGES/PXEBOOT/INITRD.IMG\;1 > os-bases/centos/var/www/static/pxe/centos-installer/7initrd
	isoinfo -i centos7.iso -x /IMAGES/PXEBOOT/VMLINUZ.\;1 > os-bases/centos/var/www/static/pxe/centos-installer/7vmlinuz
	touch centos-pxe

clean:
	$(MAKE) -C ipxe clean
	$(RM) -r build
	$(RM) *.respkg
	$(RM) ubuntu-pxe
	$(RM) centos-pxe
	$(RM) respkg

dist-clean: clean
	$(MAKE) -C ipxe dist-clean
	$(RM) -r os-bases/ubuntu/var
	$(RM) -r os-bases/centos/var
	$(RM) centos6.iso centos7.iso
	$(RM) ubuntu-pxe
	$(RM) centos-pxe

.PHONY:: all version clean dist-clean

respkg-distros:
	echo xenial

respkg-requires:
	echo respkg build-essential liblzma-dev genisoimage

respkg: ubuntu-pxe centos-pxe build/ipxe/var/lib/tftpboot/ipxe
	cd os-bases && respkg -b ../contractor-os-base_$(VERSION).respkg     -n contractor-os-base     -e $(VERSION) -c "Contractor - OS Base"               -t load_os_base.sh -d os_base
	cd os-bases && respkg -b ../contractor-ubuntu-base_$(VERSION).respkg -n contractor-ubuntu-base -e $(VERSION) -c "Contractor - Ubuntu Base"           -t load_ubuntu.sh  -d ubuntu -s contractor-os-base
	cd os-bases && respkg -b ../contractor-centos-base_$(VERSION).respkg -n contractor-centos-base -e $(VERSION) -c "Contractor - CentOS Base"           -t load_centos.sh  -d centos -s contractor-os-base
	cd vmware && respkg -b ../contractor-vmware-base_$(VERSION).respkg   -n contractor-vmware-base -e $(VERSION) -c "Contractor - VMware Base"           -t load_vmware.sh  -d vmware -s contractor-os-base -s contractor-plugins-vcenter
	cd build && respkg -b ../contractor-ipxe_$(VERSION).respkg           -n contractor-ipxe        -e $(VERSION) -c "Contractor - iPXE - Netboot loader" -y -d ipxe
	touch respkg

respkg-file:
	echo $(shell ls *.respkg)

.PHONY:: respkg-distros respkg-requires respkg respkg-file
