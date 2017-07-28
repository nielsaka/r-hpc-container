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
  R --slave -e 'install.packages(c("doMPI", "MASS", "foreach", "doRNG", "expm", "doParallel", "setRNG",
          "Rcpp", "RcppEigen", "debug", "np", "sn", "quadprog", "glmnet", "devtools", "tidyverse"), repos="http://cloud.r-project.org/")'
  R --slave -e 'devtools::install_git("https://gitlab.com/nmaka/mcs-r.git")'

%test 
  R -e "library(MCS)"

%runscript
  R -e "library(doMPI); cl <- startMPIcluster(count = 5); registerDoMPI(cl); foreach(i=1:5) %dopar% Sys.sleep(10); closeCluster(cl); mpi.quit()"
