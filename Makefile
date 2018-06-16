
all:

ipxe:
	make -C ipxe
	mkdir -p build/ipxe/var/lib/tftpboot
	cp ipxe/bin/* build/ipxe/var/lib/tftpboot

ubuntu-pxe:
	echo wget ubuntu pxe image
	echo move pxe image into os-bases/ubuntu/var/www/contractor-pxe/ubuntu-installer
	touch ubuntu-pxe

centos-pxe:
	echo wget ubuntu pxe image
	echo move pxe image into os-bases/ubuntu/var/www/contractor-pxe/centos-installer
	touch centos-pxe

.PHONY:: ipxe

respkg-distros:
	echo xenial

respkg-requires:
	echo respkg

respkg: ubuntu-pxe centos-pxe ipxe
	cd os-bases && respkg -b ../contractor-ubuntu-base_0.0.respkg -n contractor-ubuntu-base -e 0.0 -c "Contractor - Ubuntu Base" -t load_ubuntu.sh -d ubuntu -s contractor-os-base
	cd os-bases && respkg -b ../contractor-centos-base_0.0.respkg -n contractor-centos-base -e 0.0 -c "Contractor - CentOS Base" -t load_centos.sh -d centos -s contractor-os-base
	cd build && respkg -b ../contractor-ipxe_0.0.respkg -n contractor-ipxe -e 0.0 -c "Contractor - iPXE - Netboot loader" -y -d ipxe
	touch respkg

respkg-file:
	echo $(shell ls *.respkg)

.PHONY:: respkg-distros respkg-requires respkg respkg-file
