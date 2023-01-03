SUBPROJECTS := blobby cable_clip diamond fidget_cog_toy flower_pot_tray hull_chain wart_sphere

all:
	for d in $(SUBPROJECTS); do $(MAKE) -C $${d} all; done

clean:
	for d in $(SUBPROJECTS); do $(MAKE) -C $${d} clean; done

previews:
	for d in $(SUBPROJECTS); do $(MAKE) -C $${d} previews; done

stls:
	for d in $(SUBPROJECTS); do $(MAKE) -C $${d} stls; done

.PHONY: all clean previews stls