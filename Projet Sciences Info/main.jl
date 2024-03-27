include("parser.jl")
include("displaymap.jl")
include("floodfill.jl")
include("dijkstra.jl")
include("astar.jl")
include("weightedastar.jl")

#Applique Floodfill, Dijkstra et A* à la carte mise en entrée avec des points de départ et d'arrivée aléatoires
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
    
    #Effectue les trois algorithmes et affiche la carte résultante
    afficher_carte(mapini, string("Map/",fichier,"Ini.png"))
    
    getTime = time()
    afficher_carte(floodfill(map,Dep,Ar), string("Map/",fichier,"FF.png"))
    println(time() - getTime)
    
    getTime = time()
    afficher_carte(dijkstra(map,Dep,Ar), string("Map/",fichier,"Dt.png"))
    println(time() - getTime)
    
    getTime = time()
    afficher_carte(aStar(map,Dep,Ar), string("Map/",fichier,"AS.png"))
    println(time() - getTime)

end

#Applique Floodfill, Dijkstra et A* à la carte mise en entrée avec des points de départ et d'arrivée spécifiés
function appliquer_algos_bis(fichier::String, Dep::Tuple{Int64,Int64}, Ar::Tuple{Int64,Int64})

    map = parseMap(string("Benchmarks/",fichier))
    println("Départ : ", Dep, "\nArrivée : ", Ar)

    mapini = copy(map)
    mapini[Dep[1],Dep[2]] = 'D'
    mapini[Ar[1],Ar[2]] = 'A'
    
    afficher_carte(mapini, "Carte initiale")
    
    getTime = time()
    afficher_carte(floodfill(map,Dep,Ar), "FloodFill")
    println(time() - getTime)
    
    getTime = time()
    afficher_carte(dijkstra(map,Dep,Ar), "Dijkstra")
    println(time() - getTime)
    
    getTime = time()
    afficher_carte(aStar(map,Dep,Ar), "A*")
    println(time() - getTime)

end

#Applique A*, WA* et DWA* à la carte mise en entrée avec des points de départ et d'arrivée et un w spécifiés
function appliquer_astar(fichier::String, w2::Float64)

    map = parseMap(string("Benchmarks/",fichier))
    h = size(map,1)
    w = size(map,2)
    
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
    
    afficher_carte(mapini, "Carte initiale")
    
    getTime = time()
    afficher_carte(aStar(map,Dep,Ar), "A*")
    println(time() - getTime)
    
    getTime = time()
    afficher_carte(weightedAStar(map,Dep,Ar,w2), "WA*")
    println(time() - getTime)
    
    getTime = time()
    afficher_carte(dynamicWeightedAStar(map,Dep,Ar), "DWA*")
    println(time() - getTime)

end

#Applique A*, WA* et DWA* à la carte mise en entrée avec des points de départ et d'arrivée aléatoires et un w spécifié
function appliquer_astar_bis(fichier::String, Dep::Tuple{Int64,Int64}, Ar::Tuple{Int64,Int64}, w::Float64)
    map = parseMap(string("Benchmarks/",fichier))
    println("Départ : ", Dep, "\nArrivée : ", Ar)

    mapini = copy(map)
    mapini[Dep[1],Dep[2]] = 'D'
    mapini[Ar[1],Ar[2]] = 'A'
    
    afficher_carte(mapini, "Carte initiale")
    
    getTime = time()
    afficher_carte(aStar(map,Dep,Ar), "A*")
    println(time() - getTime)
    
    getTime = time()
    afficher_carte(weightedAStar(map,Dep,Ar,w), "WA*")
    println(time() - getTime)
    
    getTime = time()
    afficher_carte(dynamicWeightedAStar(map,Dep,Ar), "DWA*")
    println(time() - getTime)

end


