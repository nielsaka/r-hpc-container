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
	&& install2.r \
		-r "http://bioconductor.org/packages/3.3/bioc/" \
		graph \
		RBGL \
		Rgraphviz \
	&& install2.r \
		vars \
		tools \
		doRNG \
		pcalg \
		dplyr \
		purrr \
		tidyr \
		ggplot2 \
		Hmisc \
		zoo \
		remotes \
	## specify commit or tag?
	&& installGithub.r \
		nielsaka/charms \
	## remotes::install_gitlab not yet available
	&& Rscript -e 'remotes::install_url("https://gitlab.com/nmaka/causal_svar_r_package/-/archive/master/causal_svar_r_package-master.tar.gz")'

CMD /bin/sh


# Latex packages??
RUN tlmgr install koma-script todonotes xcolor pgf mathtools preprint enumitem acronym bigfoot xstring beebe



# this is for 'fooling' package management into considering
# texlive installed

# see https://yihui.name/tinytex/faq/

#RUN wget "https://travis-bin.yihui.name/texlive-local.deb" \
#  && dpkg -i texlive-local.deb \
#  && rm texlive-local.deb \
#  
#  ## Use tinytex for LaTeX installation
#  && install2.r --error tinytex #\

#  # What are these packages for?
#  && tlmgr install metafont mfware inconsolata tex ae parskip listings \
## What does "path add" do??
#  && tlmgr path add \
#  # Why add R texmf tree? Only for R package docs?
#  && Rscript -e "tinytex::r_texmf()" \
#  && chown -R root:staff /opt/TinyTeX \
#  && chmod -R a+w /opt/TinyTeX \
#  && chmod -R a+wx /opt/TinyTeX/bin \
#  && echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron \



