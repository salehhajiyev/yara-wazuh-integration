#Install Dependencies

apt-get install automake jq libtool libssl-dev make gcc pkg-config git libjansson-dev libmagic-dev -y
mkdir /usr/share/yara
cd /usr/share/yara
wget https://github.com/VirusTotal/yara/archive/refs/tags/v4.2.3.tar.gz
