include("parser.jl")
include("displaymap.jl")
include("floodfill.jl")
include("dijkstra.jl")
include("astar.jl")

function appliquer_algos(fichier::String)
    #Crée la matrice représentatrice de la carte
    map = parseMap(string("Benchmarks/",fichier))
    h = size(map,1)
    w = size(map,2)
    
    #Initialise les points d'arrivée et de départ jusqu'à ce qu'ils soient valides
    Dep = rand(1:h),rand(1:w)
    Ar = rand(1:h),rand(1:w)

    while (map[Dep[1],Dep[2]] == '@' || map[Dep[1],Dep[2]] == 'O' || map[Dep[1],Dep[2]] == 'T')
        Dep = rand(1:h),rand(1:w)
    end

    while (map[Ar[1],Ar[2]] == '@' || map[Ar[1],Ar[2]] == 'O' || map[Ar[1],Ar[2]] == 'T')
        Ar = rand(1:h),rand(1:w)
    end
    
    println("Départ : ", Dep, "\nArrivée : ", Ar)

    mapini = copy(map)
    mapini[Dep[1],Dep[2]] = 'D'
    mapini[Ar[1],Ar[2]] = 'A'
    
    #Effectue les trois algorithmes et sauvegarde les cartes dans le dossier Map
    afficher_carte(mapini, string("Map/",fichier,"Ini.png"))
    afficher_carte(floodfill(map,Dep,Ar), string("Map/",fichier,"FF.png"))
    afficher_carte(dijkstra(map,Dep,Ar), string("Map/",fichier,"Dt.png"))
    afficher_carte(aStar(map,Dep,Ar), string("Map/",fichier,"AS.png"))

end
