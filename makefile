build_dir := build
src_dir := src

document_name := resume-silas-waxter

theme_dir := resources/themes
theme_name := resume

document_src := $(shell find $(src_dir)/ -name "*.adoc")

.phony: clean all

all: $(build_dir)/$(document_name).pdf $(build_dir)/$(document_name).png

$(build_dir)/$(document_name).pdf: $(src_dir)/main.adoc $(document_src) \
																	 $(theme_dir)/$(theme_name)-theme.yml
	docker run -v $(shell pwd):/documents/ \
		--rm \
		asciidoctor/docker-asciidoctor \
		asciidoctor-pdf \
		-a pdf-themesdir=$(theme_dir) \
		--theme $(theme_name) \
		$< \
		-o $@

$(build_dir)/$(document_name).png: $(build_dir)/$(document_name).pdf
	convert $< $@

clean:
	rm -rf $(build_dir)/*

