ssh user@62.84.124.205     hostname: lf-app1   web     runner: lf-runner1
ssh user@84.201.156.203     hostname: lf-app2   db      runner: lf-runner2

vm_ip_addresses_all = {
  "vminstance-1" = "89.169.155.130"
  "vminstance-2" = "89.169.149.141"
}

wget https://go.dev/dl/go1.23.8.linux-amd64.tar.gz
sudo su
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.8.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version

git clone https://github.com/docker/compose.git
cd compose/

apt install make
make
/home/user/compose/bin/build/docker-compose


real    1m53.506s
real    8m21.896s
real    6m20.178s