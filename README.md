BICHRI Marwan 212758J

Livrable pour le projet d'informatique scientifique.

Pkg utilisés : Match, Images, Colors

include main.jl puis appeler la fonction appliquer_algos en mettant le nom du fichier .map en entrée (pas le chemin, la fonction va automatiquement aller chercher dans le dossier Benchmarks).

La fonction affiche la distance parcourue et le nombre d'états visité pour chaque algorithme, et sauvegarde les données des cartes sous formes de png dans le dossier Map.

Les cartes sont représentées en image dont chaque pixel représente une case.

Noir : Obstacle
Blanc : Terrain
Vert : Arbre
Bleu : Eau / Point de Départ
Orange : Sable
Rouge : Chemin emprunté
Magenta : Point d'arrivée

Dans le dossier Map sont inclus les derniers résultats des algorithmes sur les trois cartes dans Benchmarks. Appeler l'algorithme sur la même carte écrase la carte précédente, donc il faut ouvrir l'image avant de la remplacer.
