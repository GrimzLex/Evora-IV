/obj/structure/girder //girder after you dismantle the wall
	description_info = "Use metal sheets on this to build a normal wall.  Adding plasteel instead will make a reinforced wall.<br>\
	A false wall can be made by using a metal sheet on not secured girder.<br>\
	You can dismantle the grider with a wrench."
	name = "girder"
	icon_state = "reinforced"
	opacity = 0
	cover = 50
	health = 400
	state = 2

/obj/structure/girder/recipe //girder for the recipe menu.
	description_info = "Use metal sheets on this to build a normal wall.  Adding plasteel instead will make a reinforced wall.<br>\
	A false wall can be made by using a metal sheet on not secured girder.<br>\
	You can dismantle the grider with a wrench."
	name = "girder"
	icon_state = "girder"
	opacity = 0
	cover = 50
	health = 400
	state = 0

/obj/structure/girder/reinforced //girder after you dismantle the wall
	description_info = "Add another sheet of plasteel to finish."
	name = "girder"
	cover = 75
	health = 700
	state = 5
	opacity = 1
	icon_state = "r_girder2"
	reinforcing = 0

/obj/structure/grille
	description_info = "A powered and knotted wire underneath this will cause the grille to shock anyone not wearing insulated gloves.<br>\
	Wirecutters will turn the grille into metal rods instantly.  Grilles are made with metal rods."

/obj/structure/lattice
	description_info = "Add a metal floor tile to build a floor on top of the lattice.<br>\
	Lattices can be made by applying metal rods to a space tile."

/obj/structure/bed
	description_info = "Click and drag yourself (or anyone) to this to buckle in. Click on this with an empty hand to undo the buckles.<br>\
	<br>\
	Anyone with restraints, such as handcuffs, will not be able to unbuckle themselves. They must use the Resist button, or verb, to break free of \
	the buckles, instead."