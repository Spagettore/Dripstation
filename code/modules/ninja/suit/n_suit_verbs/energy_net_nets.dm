/*
It will teleport people to a holding facility after 30 seconds. (Check the process() proc to change where teleport goes)
It is possible to destroy the net by the occupant or someone else.
*/

/obj/structure/energy_net
	name = "energy net"
	desc = "It's a net made of green energy."
	icon = 'icons/effects/effects.dmi'
	icon_state = "energynet"

	density = TRUE//Can't pass through.
	opacity = 0//Can see through.
	mouse_opacity = MOUSE_OPACITY_ICON//So you can hit it with stuff.
	anchored = TRUE//Can't drag/grab the net.
	layer = ABOVE_ALL_MOB_LAYER
	max_integrity = 40 //How much health it has.
	can_buckle = 1
	buckle_lying = 0
	buckle_prevents_pull = TRUE
	var/mob/living/carbon/affecting //Who it is currently affecting, if anyone.
	var/mob/living/carbon/master //Who shot web. Will let this person know if the net was successful or failed.
	var/check = 30 // seconds before teleportation. Could be extended I guess.
	var/success = FALSE


/obj/structure/energy_net/play_attack_sound(damage, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(src, 'sound/weapons/slash.ogg', 80, 1)
		if(BURN)
			playsound(src, 'sound/weapons/slash.ogg', 80, 1)

/obj/structure/energy_net/Destroy()
	if(!success)
		if(!QDELETED(affecting))
			affecting.visible_message("[affecting.name] was recovered from the energy net!", "You were recovered from the energy net!", span_italics("You hear a grunt."))
		if(!QDELETED(master))//As long as they still exist.
			to_chat(master, "[span_userdanger("ERROR")]: unable to initiate capture protocol. Procedure terminated.")
	return ..()

/obj/structure/energy_net/process(delta_time)
	if(QDELETED(affecting)||affecting.loc!=loc)
		qdel(src)//Get rid of the net.
		return

	if(check > 0)
		check -= delta_time
		return

	success = TRUE
	qdel(src)
	if(ishuman(affecting))
		var/mob/living/carbon/human/H = affecting
		for(var/obj/item/W in H)
			if(W == H.w_uniform)
				continue//So all they're left with are shoes and uniform.
			if(W == H.shoes)
				continue
			H.dropItemToGround(W)

	playsound(affecting, 'sound/effects/sparks4.ogg', 50, 1)
	new /obj/effect/temp_visual/dir_setting/ninja/phase/out(affecting.drop_location(), affecting.dir)

	visible_message("[affecting] suddenly vanishes!")
	affecting.forceMove(pick(GLOB.holdingfacility)) //Throw mob in to the holding facility.
	GLOB.ninja_capture += affecting
	to_chat(affecting, span_danger("You appear in a strange place. You feel very trapped."))

	if(!QDELETED(master))//As long as they still exist.
		to_chat(master, span_notice("<b>SUCCESS</b>: capture procedure of [affecting] complete."))
	do_sparks(5, FALSE, affecting)
	playsound(affecting, 'sound/effects/phasein.ogg', 25, 1)
	playsound(affecting, 'sound/effects/sparks2.ogg', 50, 1)
	new /obj/effect/temp_visual/dir_setting/ninja/phase(affecting.drop_location(), affecting.dir)

/obj/structure/energy_net/attack_paw(mob/user)
	return attack_hand()

/obj/structure/energy_net/user_buckle_mob(mob/living/M, mob/living/user)
	return//We only want our target to be buckled

/obj/structure/energy_net/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	return//The net must be destroyed to free the target
