using Match

#Crée une liste de cases adjacentes à la case en entrée, en indiquant le poids de déplacement
function adj_DT(map::Matrix{Char}, coord::Tuple{Int64, Int64})
    sortie = Vector{Tuple{Tuple{Int64,Int64},Int64}}()
    if (coord[1] > 1) #Vérifie si la case n'est pas au bord de la carte, pour les quatre sens cardinaux
        push!(sortie, ((coord[1]-1,coord[2]),dist(map, coord, (coord[1]-1,coord[2]))))
    end
    if (coord[2] > 1)
        push!(sortie, ((coord[1],coord[2]-1),dist(map, coord, (coord[1],coord[2]-1))))
    end
    if (coord[1] < size(map,1))
        push!(sortie, ((coord[1]+1,coord[2]),dist(map, coord, (coord[1]+1,coord[2]))))
    end
    if (coord[2] < size(map,2))
        push!(sortie, ((coord[1],coord[2]+1),dist(map, coord, (coord[1],coord[2]+1))))
    end
    return sortie
end

#Calcule le poids de déplacement entre deux cases adjacentes
function dist(map::Matrix{Char}, coordA::Tuple{Int64, Int64}, coordB::Tuple{Int64, Int64})
    @match (map[coordA[1],coordA[2]],map[coordB[1],coordB[2]]) begin
            (a,a), if (a == '.' || a == 'G') end => 1 #Passer d'une case de sol à une autre
            (a,a), if (a == 'S' || a == 'W') end => 5 #Passer d'une case d'eau ou de sable à une autre
            (a,b), if ((a == '.' || a == 'G') && b == 'S')||((b == '.' || b == 'G') && a == 'S') end => 3 #Passer d'une case de sol à un case de sable ou inversement
            (a,b), if (a == '@' || a == 'O' || a == 'T' || b == '@' || b == 'O' || b == 'T') end => typemax(Int64) #Tenter d'accéder à une case hors limites
            ((a, 'W') || ('W', a)), if (a != 'W') end => typemax(Int64) #Tenter d'accéder à une case d'eau à partir d'un autre type de case
    end
end

#Vérifie si la case a déjà été visitée en un temps inférieur ou égal à celui indiqué
function visitePlusTot(list::Vector{Tuple{Tuple{Int64,Int64},Int64}}, elem::Tuple{Tuple{Int64,Int64},Int64})
    sortie = false
    for e in list
        sortie = sortie || (e[1] == elem[1] && e[2] <= elem[2])
    end
    return sortie
end

#Vérifie si la case a été visitée, remplace l'ancien temps d'atteinte de la case par le nouveau si oui, ajoute la case et son temps d'atteint sinon
function inserer(list::Vector{Tuple{Tuple{Int64,Int64},Int64}}, elem::Tuple{Tuple{Int64,Int64},Int64})
    trouve = false
    for i in 1:length(list)
        if (list[i][1] == elem[1])
            list[i] = elem
            trouve = true
        end
    end
    if !trouve 
        push!(list, elem)
    end
end

#Algorithme principal
function dijkstra(map::Matrix{Char}, d::Tuple{Int64,Int64}, ar::Tuple{Int64,Int64})
    visit = Vector{Tuple{Tuple{Int64,Int64},Int64}}([(d,0)])
    recherche = Vector{Tuple{Vector{Tuple{Int64,Int64}},Int64}}()
    chemins_admissibles = Vector{Tuple{Vector{Tuple{Int64,Int64}},Int64}}()
    push!(recherche, (Vector{Tuple{Int64,Int64}}([d]),0))
    while (!isempty(recherche))
        cour = recherche[1]
        popfirst!(recherche)
        for a in adj_DT(map, cour[1][end])
            if !(visitePlusTot(visit,(a[1],cour[2]+a[2])) || visitePlusTot(visit,(ar,cour[2]+a[2])) || a[2] == typemax(Int64))
                #println(visit)
                #println(a)
                inserer(visit, (a[1],cour[2]+a[2]))
                #push!(visit, (a[1],cour[2]+a[2]))
                nouv = (copy(cour[1]),cour[2]+a[2])
                push!(nouv[1], a[1])
                push!(recherche, nouv)
                if (a[1] == ar)
                    push!(chemins_admissibles, nouv)
                end
            end
         end
    end
    println("Dijkstra : \n",size(visit,1)," états visités")
    sortie = Vector{Tuple{Int64,Int64}}()
    if !isempty(chemins_admissibles)
        sortie = chemins_admissibles[end][1]
        println(chemins_admissibles[end][2], " de distance.")
    end
    nouvellemap = modifmap(copy(map),sortie)
    return nouvellemap
end
