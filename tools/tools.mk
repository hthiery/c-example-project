ALL_TARGETS += $(o)tools/example $(o)tools/spawn $(o)tools/tar
CLEAN_TARGETS += clean-tools
INSTALL_TARGETS += install-tools

example_SOURCES := tools/example.c
example_OBJECTS := $(addprefix $(o),$(example_SOURCES:.c=.o))

spawn_SOURCES := tools/spawn.c
spawn_OBJECTS := $(addprefix $(o),$(spawn_SOURCES:.c=.o))

tar_SOURCES := tools/tar.c
tar_OBJECTS := $(addprefix $(o),$(tar_SOURCES:.c=.o))

$(o)tools/%.o: tools/%.c
	$(call compile_tgt,tools)

$(o)tools/example: $(example_OBJECTS) $(o)src/libdll.a
	$(call link_tgt,tools)

$(o)tools/spawn: $(spawn_OBJECTS)
	$(call link_tgt,tools)

$(o)tools/tar: $(tar_OBJECTS)
	$(call link_tgt,tools)


clean-tools:
	rm -f $(example_OBJECTS) \
		$(example_OBJECTS) \
		$(ALL_TARGETS)

install-tools: $(o)tools/example
	$(INSTALL) -d -m 0755 $(DESTDIR)$(BINDIR)
	$(INSTALL) -m 0755 $(o)tools/example $(DESTDIR)$(BINDIR)/
