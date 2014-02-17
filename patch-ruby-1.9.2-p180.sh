#!/bin/sh

scriptdir=$(cd $(dirname $0); pwd)
echo
echo Script directory: $scriptdir

target=${1:-'/tmp/ruby-build.*.*/ruby-1.9.2-p180'}
echo
echo Target directory: $target

while :
do
    if [ -d $target ]; then
	if [ -e ${target}/ext/openssl/ossl_ssl.c ]; then
	    if [ ! -e ${target}/ext/openssl/ossl_ssl.c.orig ]; then
		echo
		echo "Applying patch to ossl_ssl.c."
		cd $target
		patch -b -p1 < ${scriptdir}/ossl_ssl.c.patch
		echo "Finished."
		echo
		exit 0
	    else
		echo
		echo "Seemed already applied patch to ossl_ssl.c."
		echo
		exit 0
	    fi
	fi
    fi
done
