.PHONY: file_rename
file_rename :
	for f in *.md ; do \
		old_name="$$f" ; \
		new_name=$$(echo "$$f" | sed -e 's/\(.*\)/\L\1/' | sed 's/ /_/g') ; \
		[ "$$old_name" != "$$new_name" ] && mv "$$old_name" "$$new_name"; \
	done ; \
	echo "rename successfully"
