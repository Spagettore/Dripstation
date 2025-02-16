/obj/item/stamp
	name = "\improper GRANTED rubber stamp"
	desc = "A rubber stamp for stamping important documents."
	icon = 'yogstation/icons/obj/bureaucracy.dmi'
	icon_state = "stamp-ok"
	item_state = "stamp"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	materials = list(/datum/material/iron=60)
	pressure_resistance = 2
	attack_verb = list("stamped")

/obj/item/stamp/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] stamps 'VOID' on [user.p_their()] forehead, then promptly falls over, dead."))
	return (OXYLOSS)

/obj/item/stamp/qm
	name = "quartermaster's rubber stamp"
	icon_state = "stamp-qm"
	dye_color = DYE_QM

/obj/item/stamp/law
	name = "law office's rubber stamp"
	icon_state = "stamp-law"
	dye_color = DYE_LAW

/obj/item/stamp/chap
	name = "chaplain's rubber stamp"
	icon_state = "stamp-chap"
	dye_color = DYE_CHAP

/obj/item/stamp/captain
	name = "captain's rubber stamp"
	icon_state = "stamp-cap"
	dye_color = DYE_CAPTAIN

/obj/item/stamp/hop
	name = "head of personnel's rubber stamp"
	icon_state = "stamp-hop"
	dye_color = DYE_HOP

/obj/item/stamp/hos
	name = "head of security's rubber stamp"
	icon_state = "stamp-hos"
	dye_color = DYE_HOS

/obj/item/stamp/warden
	name = "warden's rubber stamp"
	icon_state = "stamp-ward"
	dye_color = DYE_WARD

/obj/item/stamp/ce
	name = "chief engineer's rubber stamp"
	icon_state = "stamp-ce"
	dye_color = DYE_CE

/obj/item/stamp/rd
	name = "research director's rubber stamp"
	icon_state = "stamp-rd"
	dye_color = DYE_RD

/obj/item/stamp/cmo
	name = "chief medical officer's rubber stamp"
	icon_state = "stamp-cmo"
	dye_color = DYE_CMO

/obj/item/stamp/denied
	name = "\improper DENIED rubber stamp"
	icon_state = "stamp-deny"
	dye_color = DYE_REDCOAT

/obj/item/stamp/clown
	name = "clown's rubber stamp"
	icon_state = "stamp-clown"
	dye_color = DYE_CLOWN

/obj/item/stamp/mime
	name = "mime's rubber stamp"
	icon_state = "stamp-mime"
	dye_color = DYE_MIME

/obj/item/stamp/cent
	name = "centcom rubber stamp"
	icon_state = "stamp-cent"
	dye_color = DYE_REDCOAT

/obj/item/stamp/blueshield
	name = "Blueshield's rubber stamp"
	icon_state = "stamp-blueshield"
	dye_color = DYE_BLUES

/obj/item/stamp/magistrate
	name = "Magistrate's rubber stamp"
	icon_state = "stamp-magistrate"
	dye_color = DYE_MAGI

/obj/item/stamp/ntrep
	name = "Nanotrasen Representative's rubber stamp"
	icon_state = "stamp-rep"
	dye_color = DYE_NTREP

/obj/item/stamp/syndi
	name = "knock-off syndicate rubber stamp"
	desc = "Not a syndicate ripoff!"
	icon_state = "stamp-syndi"
	dye_color = DYE_HOS

	
/obj/item/stamp/syndiround
	name = "syndicate rubber stamp"
	icon_state = "stamp-syndiround"
	dye_color = DYE_HOS

/obj/item/stamp/attack_paw(mob/user)
	return attack_hand(user)
