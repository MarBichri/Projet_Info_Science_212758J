#Crée une liste de cases adjacentes à la case en entrée
function adj_FF(map::Matrix{Char}, coord::Tuple{Int64, Int64})
    sortie = Vector{Tuple{Int64,Int64}}()
    if (coord[1] > 1 ) #Vérifie si la case n'est pas au bord de la carte, pour les quatre sens cardinaux
         push!(sortie, (coord[1]-1,coord[2]))
     end
     if (coord[2] > 1 )
        push!(sortie, (coord[1],coord[2]-1))
    end
    if (coord[1] < size(map,1) )
        push!(sortie, (coord[1]+1,coord[2]))
    end
    if (coord[2] < size(map,2))
        push!(sortie, (coord[1],coord[2]+1))
    end

    return sortie
end

#Vérifie si la case en entrée a été atteinte
function atteint(liste::Vector{Vector{Tuple{Int64,Int64}}}, elem::Tuple{Int64,Int64})
    sortie = false
    for e in liste
        sortie = sortie || elem in e
    end
    return sortie
end

#Renvoie le chemin qui mène à la case en entrée s'il existe, sinon renvoi un vecteur vide
function cheminfinal(liste::Vector{Vector{Tuple{Int64,Int64}}}, elem::Tuple{Int64,Int64})
   sortie = []
    for e in liste
        if e[end] == elem
            sortie = e
        end
    end
    return sortie
end

#Algorithme principal
function floodfill(map::Matrix{Char}, d::Tuple{Int64,Int64}, ar::Tuple{Int64,Int64})
    visit = Vector{Tuple{Int64,Int64}}([d])
    recherche = Vector{Vector{Tuple{Int64,Int64}}}()
    push!(recherche, Vector{Tuple{Int64,Int64}}([d]))
    while (!atteint(recherche, ar) && !isempty(recherche))
        cour = recherche[1]
        popfirst!(recherche)
        for a in adj_FF(map, cour[end])
            if !(a in visit || map[a[1],a[2]] == '@') 
                #println(a)
                push!(visit, a)
                nouv = copy(cour)
                push!(nouv, a)
                push!(recherche, nouv)
            end
         end
    end
    println("Floodfill : \n", size(visit,1)," états visités")
    if atteint(recherche,ar)
        sortie = cheminfinal(recherche,ar)
        println(size(sortie,1)-1, " de distance.")
        return modifmap(copy(map),sortie)
    else
        return map
    end
end
