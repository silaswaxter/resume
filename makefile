build_dir := build
src_dir := src

document_name := resume-portfolio-silas-waxter

theme := ./theme.yml

document_src := $(shell find $(src_dir)/ -name "*.adoc")

.phony: clean

$(build_dir)/$(document_name).pdf: $(src_dir)/main.adoc $(document_src) $(theme)
	docker run -v $(shell pwd):/documents/ \
		--rm \
		asciidoctor/docker-asciidoctor \
		asciidoctor-pdf $< \
		--theme $(theme) -o $@

clean:
	rm -rf $(build_dir)/*

