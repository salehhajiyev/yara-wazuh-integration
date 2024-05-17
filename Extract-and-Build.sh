#Extract and Build

tar xvf v4.2.3.tar.gz --directory /usr/share/yara/
cd yara-4.2.3/
./bootstrap.sh
./configure --enable-cuckoo --enable-magic --enable-dotnet --with-crypto
make
make install
