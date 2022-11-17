build: 
	Rscript -e 'Rcpp::compileAttributes()' && \
		Rscript -e 'roxygen2::roxygenize()' && \
		R CMD build .

install: build
	R CMD INSTALL epiworldR_*tar.gz

README.md: README.Rmd
	Rscript --vanilla -e 'rmarkdown::render("README.Rmd")'
update:
	wget https://raw.githubusercontent.com/UofUEpi/epiworld/master/epiworld.hpp && \
		mv epiworld.hpp inst/include/epiworld.hpp 
local-update:
	rsync -avz world-epi/epiworld.hpp inst/include/epiworld.hpp

check: build
	R CMD check epiworldR_*.tar.gz

.PHONY: build update check
