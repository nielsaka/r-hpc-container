Bootstrap: debootstrap
OSVersion: xenial
MirrorURL: http://archive.ubuntu.com/ubuntu/

%post
  sed -i 's/main/main universe/g' /etc/apt/sources.list
  apt-get update

  # Install R, openmpi
  apt-get install -y --no-install-recommends r-base-dev libopenmpi-dev openmpi-bin
  apt-get clean

  # Prepare bind with host
  mkdir /etc/libibverbs.d

  # Install required R packages
  R --slave -e 'install.packages("doMPI", repos="http://cloud.r-project.org/")'

%test 
  R -e "library(doMPI)"

%runscript
  R -e "library(doMPI); cl <- startMPIcluster(count = 5); registerDoMPI(cl); foreach(i=1:5) %dopar% Sys.sleep(10); closeCluster(cl); mpi.quit()"
