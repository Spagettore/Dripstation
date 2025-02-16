/obj/structure/closet/crate/bin
	desc = "A trash bin, place your trash here for the janitor to collect."
	name = "trash bin"
	icon_state = "largebins"
	open_sound = 'sound/effects/bin_open.ogg'
	close_sound = 'sound/effects/bin_close.ogg'
	anchored = TRUE
	horizontal = FALSE
	delivery_icon = null

/obj/structure/closet/crate/bin/Initialize()
	. = ..()
	update_icon()

/obj/structure/closet/crate/bin/update_icon()
	..()
	cut_overlays()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(contents.len == 0)
		add_overlay("largebing")
		SSvis_overlays.add_vis_overlay(src, icon, "largebing", layer, EMISSIVE_PLANE)
	else if(contents.len >= storage_capacity)
		add_overlay("largebinr")
		SSvis_overlays.add_vis_overlay(src, icon, "largebinr", layer, EMISSIVE_PLANE)
	else
		add_overlay("largebino")
		SSvis_overlays.add_vis_overlay(src, icon, "largebino", layer, EMISSIVE_PLANE)

/obj/structure/closet/crate/bin/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/storage/bag/trash))
		var/obj/item/storage/bag/trash/T = W
		to_chat(user, span_notice("You fill the bag."))
		for(var/obj/item/O in src)
			SEND_SIGNAL(T, COMSIG_TRY_STORAGE_INSERT, O, user, TRUE)
		T.update_icon()
		do_animate()
	else if(istype(W, /obj/item/wrench))
		anchored = !anchored
		W.play_tool_sound(src, 75)
	else
		return ..()

/obj/structure/closet/crate/bin/proc/do_animate()
	playsound(loc, open_sound, 15, 1, -3)
	flick("animate_largebins", src)
	spawn(13)
		playsound(loc, close_sound, 15, 1, -3)
		update_icon()
