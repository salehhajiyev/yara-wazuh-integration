#!/bin/bash
# Sistem növünü təyin et

if [ -f /etc/redhat-release ]; then
    OS="redhat"
elif [ -f /etc/debian_version ]; then
    OS="debian"
else
    echo "Sistem versiyası tapılmadı. Script sadəcə Debian ve Red Hat distrolarında işləyir."
    exit 1
fi

# install dependencies
if [ "$OS" == "debian" ]; then
    echo "Debian ailəsindən sistem tapıldı."
    apt-get update
    apt-get install automake jq libtool libssl-dev make gcc pkg-config git libjansson-dev libmagic-dev -y
elif [ "$OS" == "redhat" ]; then
    echo "Red Hat ailəsindən sistem tapıldı."
    yum install epel-release -y
    yum install automake jq libtool openssl-devel make gcc pkgconfig git jansson-devel -y
fi

# YARA installation
echo "YARA install olunur..."
mkdir -p /usr/share/yara
cd /usr/share/yara
wget https://github.com/VirusTotal/yara/archive/refs/tags/v4.5.0.tar.gz
tar -xzf v4.5.0.tar.gz
cd yara-4.5.0
./bootstrap.sh
./configure
make
make install

echo "YARA install olundu"
#Download Yara Rules
cd /usr/local

git clone https://github.com/Neo23x0/signature-base.git

#Update And Compile Rules
cp yara_update_rules.sh /usr/share/yara/
cd /usr/share/yara/
chmod +x /usr/share/yara/yara_update_rules.sh
/bin/bash /usr/share/yara/yara_update_rules.sh

#test yara
cd /tmp/
wget https://secure.eicar.org/eicar.com
/usr/share/yara/yara-4.5.0/yara -C -w -r -f -m /usr/local/signature-base/yara_base_ruleset_compiled.yar eicar.com 
