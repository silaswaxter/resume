build_dir := build
src_dir := src

document_name := resume.pdf
readable_pdf := $(build_dir)/$(document_name)

theme := ./theme.yml

document_top_src	:= $(src_dir)/main.adoc
document_src := $(shell find $(src_dir)/ -name "*.adoc")

.phony: clean

$(readable_pdf): $(document_top_src) $(document_src) $(theme)
	docker run -v $(shell pwd):/documents/ \
		--rm \
		asciidoctor/docker-asciidoctor \
		asciidoctor-pdf $< \
		--theme $(theme) -o $@

clean:
	rm -rf $(build_dir)/*

