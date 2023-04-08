#define SYNDICATE_CHALLENGE_TIMER 12000 //20 minutes

/obj/machinery/computer/shuttle/syndicate
	name = "syndicate shuttle terminal"
	desc = "The terminal used to control the syndicate transport shuttle."
	circuit = /obj/item/circuitboard/computer/syndicate_shuttle
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = LIGHT_COLOR_RED
	req_access = list(ACCESS_SYNDICATE)
	shuttleId = "syndicate"
	possible_destinations = "syndicate_away;syndicate_z5;syndicate_ne;syndicate_nw;syndicate_n;syndicate_se;syndicate_sw;syndicate_s;spacebar;syndicate_custom"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	flags_1 = NODECONSTRUCT_1

/obj/machinery/computer/shuttle/syndicate/allowed(mob/M)
	if(issilicon(M) && !(ROLE_SYNDICATE in M.faction))
		return FALSE
	return ..()

/obj/machinery/computer/shuttle/syndicate/launch_check(mob/user)
	. = ..()
	if(!.)
		return FALSE
	var/obj/item/circuitboard/computer/syndicate_shuttle/board = circuit
	if(board?.challenge && world.time < SYNDICATE_CHALLENGE_TIMER)
		to_chat(user, span_warning("You've issued a combat challenge to the station! You've got to give them at least [DisplayTimeText(SYNDICATE_CHALLENGE_TIMER - world.time)] more to allow them to prepare."))
		return FALSE
	board.moved = TRUE
	return TRUE

/obj/machinery/computer/shuttle/syndicate/recall
	name = "syndicate shuttle recall terminal"
	desc = "Use this if your friends left you behind."
	possible_destinations = "syndicate_away"

/obj/machinery/computer/shuttle/syndicate/drop_pod
	name = "syndicate assault pod control"
	desc = "Controls the drop pod's launch system."
	icon = 'icons/obj/terminals.dmi'
	icon_state = "pod_off"
	icon_keyboard = null
	icon_screen = "pod_on"	
	light_color = LIGHT_COLOR_BLUE
	req_access = list(ACCESS_SYNDICATE)
	shuttleId = "steel_rain"
	possible_destinations = null
	clockwork = TRUE //it'd look weird

/obj/machinery/computer/shuttle/syndicate/drop_pod/update_icon()
	cut_overlays()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(!(stat & (NOPOWER|BROKEN)))
		add_overlay(icon_screen)
		SSvis_overlays.add_vis_overlay(src, icon, icon_screen, layer, EMISSIVE_PLANE, dir)

/obj/machinery/requests_console/power_change()
	. = ..()
	if(!.)
		return // reduce unneeded light changes
	if(stat & NOPOWER)
		set_light(FALSE)
	else
		set_light(TRUE)

/obj/machinery/computer/shuttle/syndicate/drop_pod/launch_check(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(!is_centcom_level(z))
		to_chat(user, span_warning("Pods are one way!"))
		return FALSE
	return TRUE

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate
	name = "syndicate shuttle navigation computer"
	desc = "Used to designate a precise transit location for the syndicate shuttle."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttleId = "syndicate"
	lock_override = CAMERA_LOCK_STATION
	shuttlePortId = "syndicate_custom"
	jumpto_ports = list("syndicate_ne" = 1, "syndicate_nw" = 1, "syndicate_n" = 1, "syndicate_se" = 1, "syndicate_sw" = 1, "syndicate_s" = 1)
	view_range = 5.5
	x_offset = -7
	y_offset = -1
	see_hidden = TRUE

#undef SYNDICATE_CHALLENGE_TIMER
