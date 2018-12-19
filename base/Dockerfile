FROM rocker/r-ver:3.3.3

ENV PATH=$PATH:/opt/TinyTeX/bin/x86_64-linux/

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		# download installation files
		wget \
		# tinytex installation requires perl (can remove afterwards?)
		# latexmk is a perl script
		perl \
		# GNU MP headers required by gmp R package (dependency of pcalg)
		libgmp-dev \
	## Use tagged version with installGithub.r instead?
	## or remotes::install_version()
	&& install2.r -r https://cran.rstudio.com tinytex \
  	## Admin-based install of TinyTeX: (Why Admin?)
  	&& wget -qO- \
    	"https://github.com/yihui/tinytex/raw/master/tools/install-unx.sh" | \
    	sh -s - --admin --no-path \
  	&& mv ~/.TinyTeX /opt/TinyTeX \
  	&& /opt/TinyTeX/bin/*/tlmgr path add \

CMD /bin/sh
