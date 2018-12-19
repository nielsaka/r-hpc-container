FROM nielsaka/rubic:graphs

## specify commit or tag?
RUN installGithub.r \
		nielsaka/charms \
	## remotes::install_gitlab not yet available
	&& Rscript -e 'remotes::install_url("https://gitlab.com/nmaka/causal_svar_r_package/-/archive/master/causal_svar_r_package-master.tar.gz")'

CMD /bin/sh
