#INSTALL-ALL.sh

sudo apt-get install build-essential gfortran gdb -y

# FOR MPICH
if test [ "$1" == "mpich" ]; then
	sudo apt-get install mpich -y
fi

# FOR OPENMPI
if [ "$1" == "openmpi" ]; then
	sudo apt-get install openmpi-bin openmpi-dev libopenmpi-dev -y
fi

# FOR MVAPICH
if [ "$1" == "mvapich" ]; then
	sudo apt-get install libtool autoconf libibverbs-dev bison byacc -y
	wget http://mvapich.cse.ohio-state.edu/download/mvapich/mv2/mvapich2-2.3.1.tar.gz
	tar xf mvapich2-2.3.1.tar.gz
	rm mvapich2-2.3.1.tar.gz
	cd mvapich2-2.3.1
	sudo ./configure --disable-mcast
	autoreconf -f -i
	sudo make FFLAGS=-Wno-argument-mismatch
	sudo make install
fi

wget https://github.com/raphaelprados/TCC-2023-2/raw/main/dmtcp-2.5.2.tar.gz
tar xf dmtcp-2.5.2.tar.gz
rm dmtcp-2.5.2.tar.gz
cd dmtcp-2.5.2
sudo ./configure
sudo make
sudo make install
ssh cnode which dmtcp_launch
ssh-keygen -t dsa
ssh-keygen -t rsa
cat ~/.ssh/id*.pub >> ~/.ssh/authorized_keys
cd ..

wget https://nas.nasa.gov/assets/npb/NPB3.4.2.tar.gz
tar xf NPB3.4.2.tar.gz
rm NPB3.4.2.tar.gz
cd NPB3.4.2/NPB3.4-MPI
nano config/make.def.template
make bt CLASS=E
make lu CLASS=E
make ft CLASS=E
cd ../..


