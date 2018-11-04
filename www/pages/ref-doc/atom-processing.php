<div class="container py-2 px-0"><h4 id="atom_length/2"><a href="/fasill/documentation/ref/atom-processing#atom_length/2">atom_length/2</a></h4><p class="text-secondary">Length of an atom.</p><?php echo show_template("atom_length( +atom, ?integer )"); ?><p><?php echo show_description("atom_length(Atom, Length) is true if and only if the number of characters in the name of Atom is equal to Length. If Length is not instantiated, atom_length will calculate the length of Atom's name."); ?></p></div>
<div class="container py-2 px-0"><h4 id="atom_concat/3"><a href="/fasill/documentation/ref/atom-processing#atom_concat/3">atom_concat/3</a></h4><p class="text-secondary">Concatenate characters.</p><?php echo show_template("atom_concat( ?atom, ?atom +atom )"); ?><?php echo show_template("atom_concat( +atom, +atom, -atom )"); ?><p><?php echo show_description("atom_concat(Start, End, Whole) is true if and only if Whole is the atom obtained by adding the characters of End at the end of Start. If Whole is the only argument instantiated, atom_concat/3 will obtain all possible decompositions of it."); ?></p></div>