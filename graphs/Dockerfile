FROM nielsaka/rubic:base

RUN install2.r \
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
		remotes

CMD /bin/sh

# Latex packages
RUN tlmgr install koma-script todonotes xcolor pgf mathtools preprint enumitem acronym bigfoot xstring beebe
