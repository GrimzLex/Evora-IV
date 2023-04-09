/obj/item/device/boombox
	name = "Audioslate Player"
	icon = 'icons/obj/boombox.dmi'
	icon_state = "boombox"
	desc = "You should insert some tapes into this thing."
	var/obj/item/device/cassette/casseta = null
	var/datum/sound_token/sound_token
	var/playing = 0
	var/sound_id
	w_class = ITEM_SIZE_NO_CONTAINER

/obj/item/device/boombox/New()
	..()
	sound_id = "[type]_[sequential_id(type)]"


/obj/item/device/boombox/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/device/cassette))
		if(casseta)
			to_chat(user, "<span class='warning'>There is already cassette inside.</span>")
			return
		if(!user.unEquip(I))
			return
		I.forceMove(src)
		casseta = I
		visible_message("<span class='notice'>[user] insert cassette into [src].</span>")
		playsound(get_turf(src), 'sound/machines/bominside.ogg', 50, 1)
		return
	..()


/obj/item/device/boombox/MouseDrop(var/obj/over_object)
	if (!over_object || !(ishuman(usr) || issmall(usr)))
		return

	if (!(src.loc == usr))
		return

	switch(over_object.name)
		if("r_hand")
			eject()
		if("l_hand")
			eject()




/obj/item/device/boombox/proc/eject()
	if(usr.incapacitated())
		return
	if(!casseta)
		to_chat(usr, "<span class='warning'>There is no cassette inside.</span>")
		return

	if(playing)
		StopPlaying()
	visible_message("<span class='notice'>[usr] ejects cassette from [src].</span>")
	playsound(get_turf(src), 'sound/machines/bominside.ogg', 50, 1)
	usr.put_in_hands(casseta)
	casseta = null

/obj/item/device/boombox/attack_self(mob/user)
	if(playing)
		StopPlaying()
		playsound(get_turf(src), 'sound/machines/bomclick.ogg', 50, 1)
		return
	else
		StartPlaying()
		playsound(get_turf(src), 'sound/machines/bomclick.ogg', 50, 1)


/obj/item/device/boombox/proc/StopPlaying()
	playing = 0
	QDEL_NULL(sound_token)

/obj/item/device/boombox/proc/StartPlaying()
	StopPlaying()
	if(isnull(casseta))
		return
	if(!casseta.sound_inside)
		return

	sound_token = sound_player.PlayLoopingSound(src, sound_id, casseta.sound_inside, volume = 40, range = 10, falloff = 3, prefer_mute = TRUE, ignore_vis = TRUE)
	playing = 1

/obj/item/device/cassette
	name = "cassette tape"
	desc = "A tape smuggled in from somewhere in the outside world. Contains some bumping tunes on it."
	icon = 'icons/obj/cassette.dmi'
	icon_state = "cassette_0"
	var/sound/sound_inside
	w_class = ITEM_SIZE_TINY
	var/uploader_idiot
	var/current_side = 1
	var/sound/a_side
	var/sound/b_side

/obj/item/device/cassette/New()
	icon_state = "cassette_[rand(0,12)]"

/obj/item/device/cassette/attack_self(mob/user)
	. = ..()
	if(current_side == 1)
		sound_inside = b_side
		current_side = 2
		to_chat(user, "<span class='notice'>You flip the cassette over to the b-side.")
	else
		sound_inside = a_side
		current_side = 1
		to_chat(user, "<span class='notice'>You flip the cassette over to the a-side.")

/obj/item/device/cassette/tape1/New()
	..()
	name = "\"Evora\'s Greatest Hits Vol.1\" magn-o-tape"
	a_side = pick('sound/music/boombox1.ogg',)
	b_side = 'sound/music/boombox3.ogg'
	sound_inside = a_side

/obj/item/device/cassette/tape2/New()
	..()
	name = "Worn \"Evora\'s Greatest Hits Vol.2\" magn-o-tape"
	a_side = pick('sound/music/boombox2.ogg', 'sound/music/boombox4.ogg')
	b_side = 'sound/music/boombox5.ogg'
	sound_inside = a_side

/obj/item/device/cassette/tape3/New()
	..()
	name = "\"Evora\'s Greatest Hits Vol.3\" magn-o-tape"
	a_side = pick('sound/music/boombox7.ogg', 'sound/music/boombox2.ogg')
	b_side = pick('sound/music/boombox9.ogg', 'sound/music/boombox10.ogg')
	sound_inside = a_side

/obj/item/device/cassette/tape4/New()
	..()
	name = "\"Evora\'s Greatest Hits Vol.4\" magn-o-tape"
	a_side = pick('sound/music/inn.ogg',)
	b_side = pick('sound/music/boombox9.ogg', 'sound/music/boombox10.ogg')
	sound_inside = a_side

/obj/item/device/cassette/tape5/New()
	..()
	name = "\"The Officio Prefectus-Approved Morale Boosting Chants\" magn-o-tape"
	a_side = pick('sound/music/boombox11.ogg', 'sound/music/boombox12.ogg')
	b_side = pick('sound/music/boombox2.ogg', 'sound/music/boombox15.ogg')
	current_side = 2
	sound_inside = b_side

/obj/item/device/cassette/tape6/New()
	..()
	name = "\"The General Fabricator-Approved Music\" magn-o-tape"
	a_side = pick('sound/newmusic/omnissiah.ogg')
	b_side = pick('sound/newmusic/omnissiah.ogg')
	sound_inside = a_side

/obj/item/device/cassette/tape7/New()
	..()
	name = "forgotten magn-o-tape"
	a_side = pick('sound/newmusic/forgotten.ogg')
	b_side = pick('sound/newmusic/forgotten.ogg')
	sound_inside = a_side

/obj/item/device/cassette/Manortape/New()
	..()
	name = "fancy magn-o-tape"
	a_side = pick('sound/newmusic/clara2.ogg')
	b_side = pick('sound/newmusic/clara1.ogg')
	sound_inside = a_side

/obj/item/device/cassette/unknownsoldier/New()
	..()
	name = "The Unknown Soldier"
	a_side = pick('sound/newmusic/TAPE-unknownsoldier.ogg')
	b_side = pick('sound/newmusic/TAPE-unknownsoldier.ogg')
	sound_inside = a_side

/obj/item/device/cassette/daboss/New()
	..()
	name = "Da Boss"
	a_side = pick('sound/newmusic/TAPE-DABOSS1.ogg')
	b_side = pick('sound/newmusic/TAPE-DABOSS1.ogg')
	sound_inside = a_side

/obj/item/device/cassette/grimdark/New()
	..()
	name = "The Grimdark"
	a_side = pick('sound/newmusic/TAPE-GRIMDARK1.ogg')
	b_side = pick('sound/newmusic/TAPE-GRIMDARK1.ogg')
	sound_inside = a_side

/obj/item/device/cassette/buildin/New()
	..()
	name = "Serf Music"
	a_side = pick('sound/newmusic/TUPE-BUILDIN1.ogg')
	b_side = pick('sound/newmusic/TUPE-BUILDIN1.ogg')
	sound_inside = a_side

/obj/item/device/cassette/orks1/New()
	..()
	name = "Ork Jamma's"
	a_side = pick('sound/newmusic/TUPE-ORKS1.ogg')
	b_side = pick('sound/newmusic/TUPE-ORKS1.ogg')
	sound_inside = a_side

/obj/item/device/cassette/church1/New()
	..()
	name = "Monastery Chants"
	a_side = pick('sound/newmusic/TUPE-CHURCH1.ogg')
	b_side = pick('sound/newmusic/TUPE-CHURCH1.ogg')
	sound_inside = a_side

/obj/item/device/cassette/church2/New()
	..()
	name = "Versa est in Luctum"
	a_side = pick('sound/newmusic/TUPE-CHURCH2.ogg')
	b_side = pick('sound/newmusic/TUPE-CHURCH2.ogg')
	sound_inside = a_side

/obj/item/device/cassette/church3/New()
	..()
	name = "Cantate Domino"
	a_side = pick('sound/newmusic/TUPE-CHURCH3.ogg')
	b_side = pick('sound/newmusic/TUPE-CHURCH3.ogg')
	sound_inside = a_side

/obj/item/device/cassette/sombre1/New()
	..()
	name = "Sombre Song's A"
	a_side = pick('sound/newmusic/TUPE-SOMBRE1.ogg')
	b_side = pick('sound/newmusic/TUPE-SOMBRE1.ogg')
	sound_inside = a_side

/obj/item/device/cassette/sombre2/New()
	..()
	name = "Sombre Song's B"
	a_side = pick('sound/newmusic/TUPE-SOMBRE2.ogg')
	b_side = pick('sound/newmusic/TUPE-SOMBRE2.ogg')
	sound_inside = a_side

/obj/item/device/cassette/western1/New()
	..()
	name = "Western Stuff"
	a_side = pick('sound/newmusic/TUPE-WESTERN1.ogg')
	b_side = pick('sound/newmusic/TUPE-WESTERN1.ogg')
	sound_inside = a_side

/obj/item/device/cassette/clockwork1/New()
	..()
	name = "Clockwork"
	a_side = pick('sound/newmusic/TUPE-CLOCKWORK1.ogg')
	b_side = pick('sound/newmusic/TUPE-CLOCKWORK1.ogg')
	sound_inside = a_side

/obj/item/device/cassette/inn1/New()
	..()
	name = "Calm Tavern"
	a_side = pick('sound/newmusic/Inn_Ambient.ogg')
	b_side = pick('sound/newmusic/Inn_Ambient.ogg')
	sound_inside = a_side

/obj/item/device/cassette/inn2/New()
	..()
	name = "Strange Music"
	a_side = pick('sound/newmusic/TAPE-INNMED.ogg')
	b_side = pick('sound/newmusic/TAPE-INNMED.ogg')
	sound_inside = a_side

/obj/item/device/cassette/heresy1/New()
	..()
	name = "Confiscated Tape"
	a_side = pick('sound/newmusic/TAPE-forbidden.ogg')
	b_side = pick('sound/newmusic/TAPE-forbidden.ogg')
	sound_inside = a_side

/obj/item/device/cassette/heresy2/New()
	..()
	name = "Sororitas Secret Tape"
	a_side = pick('sound/newmusic/TAPE-forbidden2.ogg')
	b_side = pick('sound/newmusic/TAPE-forbidden2.ogg')
	sound_inside = a_side

/obj/item/device/cassette/inn3/New()
	..()
	name = "Totally Transcendent"
	a_side = pick('sound/newmusic/TAPE-INNLOUD.ogg')
	b_side = pick('sound/newmusic/TAPE-INNLOUD.ogg')
	sound_inside = a_side

/obj/item/device/cassette/inn4/New()
	..()
	name = "Whirling In Rags"
	a_side = pick('sound/newmusic/TAPE-INNCALM.ogg')
	b_side = pick('sound/newmusic/TAPE-INNCALM.ogg')
	sound_inside = a_side

/obj/item/device/cassette/duel/New()
	..()
	name = "Dueling Music"
	a_side = pick('sound/newmusic/TAPE-DUEL.ogg')
	b_side = pick('sound/newmusic/TAPE-DUEL.ogg')
	sound_inside = a_side

/obj/item/device/cassette/demon/New()
	..()
	name = "Rip & Tear"
	a_side = pick('sound/newmusic/TAPE-DEMON.ogg')
	b_side = pick('sound/newmusic/TAPE-DEMON.ogg')
	sound_inside = a_side

/obj/item/device/cassette/demon2/New()
	..()
	name = "The Archenemy"
	a_side = pick('sound/newmusic/TAPE-DEMON2.ogg')
	b_side = pick('sound/newmusic/TAPE-DEMON2.ogg')
	sound_inside = a_side