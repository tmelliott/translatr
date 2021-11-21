inst/introduction.sqlite: data-raw/intro_database.R
	@echo 'Re-building database ...'
	@rm -r $@
	@Rscript $^

document: inst/introduction.sqlite
	@echo 'Writing documentation ...'
	@Rscript --silent -e 'roxygen2::roxygenize()'

test: document
	@Rscript -e 'devtools::test()'

README.md: README.Rmd
	@echo 'Rendering README ...'
	@Rscript --silent -e 'devtools::load_all(); rmarkdown::render("$^", quiet = TRUE)'
	@rm -f README.html

site: README.md document
	@Rscript -e 'pkgdown::build_site()'
