window.onload = () => {
    // on définie la valeur qui fait référence à la table qu'on veut trier
    const dataTable = document.querySelector('table')

    // fonction qui récupère la valeur d'une cellule en fonction de sa ligne et de son index dans la ligne
    // Si innertext ne renvoie rien (car innerText renvoie le texte VISIBLE d'un objet) on prend textContent,
    // qui renvoie le texte comme étant dans le fichier HTML, visible ou non.
    const getValeurCellule = (tr, index) => tr.children[index].innerText || tr.children[index].textContent;

    // comparateur est une fonction qui, en lui passant un index de colonne (le numéro de
    // colonne, la troisième colonne sera columnIndex 2) et un sens de tri (estAscendant :
    // booléen, si Faux : sens descendant), peut trier en utilisant ses sous-fonctions
    // chaque case de cette colonne par rapport à la case suivante.
    // Ici, on fixe deux valeurs qui seront alors écrites en dur dans les sous-fonctions :
    // l'index de la colonne et le sens de tri.
    var comparateur = function(columnIndex, estAscendant) {

        // a et b ne sont pas passés explicitement, ils sont égaux aux cases N et N+1 de
	// la colonne que l'on trie. Sort() les passera implicitement lorsqu'il sera appelé.
        return function(a, b) {

            // Cette fonction est appelée directement (quelques lignes plus bas qu'ici !).
	    // En fonction du sens de tri, v1 et v2 seront égaux à a et b, interchangeablement.
            return function(v1, v2) {

                // Si v1 et v2 sont numériques : on fait simplement v1 - v2, et ça renvoie un
		// nombre négatif (v1 vient avant v2), 0 (c'est égal) ou nombre positif (v2 vient après v1).
		// Si v1 et/ou v2 est une / sont des string(s), on utilise localeCompare() pour
		// renvoyer -1 (v1 vient avant v2), 0 (c'est égal) ou 1 (v2 vient après v1).
                return (v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2))
                    ? v1 - v2
                    : v1.toString().localeCompare(v2, undefined, {numeric: true});
	    // On passe à v1 et v2 les valeurs des cellules a puis b respectivement si c'est ascendant, ou b puis a si c'est descendant
            }(getValeurCellule(estAscendant ? a : b, columnIndex), getValeurCellule(estAscendant ? b : a, columnIndex));
        }
    };

    // on ajoute un évènement click au titre de chaque colonne
    document.querySelectorAll('th').forEach(th => th.addEventListener('click', (() => {
	// pour chaque ligne à partir de la seconde
        Array.from(dataTable.querySelectorAll('tr:nth-child(n+2)'))
	    // On la compare avec la suivante en l'envoyant dans comparateur.
            // Pour ce faire, on passe à comparateur l'index de la colonne (en prenant l'index de th dans
	    // la liste des enfants de sa ligne parente), ainsi que la propriété ascendante / descendante
	    // du tri, qu'on inverse en même temps !
	    // Comparateur, avec ces paramètres, crée et renvoie la fonction (a,b) que sort() utilise.
            .sort(comparateur(Array.from(th.parentNode.children).indexOf(th), this.estAscendant = !this.estAscendant))
            .forEach(tr => dataTable.appendChild(tr));
    })));

    // Enfin, on crée une liste des lignes de la table...
    var rows = dataTable.getElementsByTagName("tbody")[0].getElementsByTagName("tr");

    // Et on itère à travers chacune de ces lignes pour changer sa couleur en fonction de son statut :
    // Réussi ou Échoué (Gravité basse - moyenne - haute).
    Array.from(rows).forEach((row) => {
        if (getValeurCellule(row, 6) == 'Failed'){
	    switch (getValeurCellule(row, 7)) {
                case 'High':
                    row.className = "red";
                    break;
                case 'Medium':
                    row.className = "orange";
                    break;
                case 'Low':
                    row.className = "yellow";
                    break;
            }
        }
    });
};
