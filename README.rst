Resources
=========


Various required/usefull resources


see http://t3kton.github.io

Note
----

The os-base for Centos uses a guest id that was created in VCenter 6.7, if you
are using a version of VCenter before that run `make oldvcenter` to patch the
guest id to a usable version.  To switch back to the 6.7 guest ids, run
`make newvcenter`.

iPXE
----

These provides the PXE boot files needed for contractor to controll booting behavor
