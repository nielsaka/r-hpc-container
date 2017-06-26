Bootstrap: debootstrap
OSVersion: stretch
MirrorURL: http://ftp.us.debian.org/debian/

%post
  apt-get update

  # Install R, openmpi
  apt-get install -y --no-install-recommends r-base-dev libopenmpi-dev openmpi-bin
  apt-get clean

  # Prepare bind with host
  mkdir /etc/libibverbs.d

  # Install required R packages
  R --slave -e 'install.packages("doMPI", repos="http://cloud.r-project.org/")'

%runscript
  R -e "library(doMPI); cl <- startMPIcluster(count = 5); registerDoMPI(cl); foreach(i=1:5) %dopar% Sys.sleep(10); closeCluster(cl); mpi.quit()"
