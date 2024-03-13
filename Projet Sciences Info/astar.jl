#Retourne la distance heuristique entre deux points
function h(d::Tuple{Int64,Int64}, a::Tuple{Int64, Int64})
	return(abs(d[1] - a[1]) + abs(d[2] - a[2]))
end

#Ajoute un chemin dans une liste triée selon la valeur de sa fonction f
function ajoutTri(list::Vector{Tuple{Vector{Tuple{Int64,Int64}},Int64,Int64}}, chem::Tuple{Vector{Tuple{Int64,Int64}},Int64,Int64})
trouve = false
i = 1
	while (!trouve && i <= size(list,1))
		trouve = (list[i][2] + list[i][3] > chem[2] + chem[3])
		
		i+=1
		
	end
	
	if (trouve)
	insert!(list,i-1,chem)
	else
	push!(list,chem)
	end
end

#Vérifie si un point a déjà été visité
function present(list::Vector{Tuple{Tuple{Int64,Int64},Int64}}, elem::Tuple{Int64,Int64})
	sortie = false
	for e in list
		sortie = sortie || (e[1] == elem)
	end
	return sortie
end

#Algorithme principal
function aStar(map::Matrix{Char}, d::Tuple{Int64,Int64}, ar::Tuple{Int64,Int64})
    arrive = false
    sortie = (((),()),(),())
    visit = Vector{Tuple{Tuple{Int64,Int64},Int64}}([(d,0)])
    recherche = Vector{Tuple{Vector{Tuple{Int64,Int64}},Int64,Int64}}()
    chemins_admissibles = Vector{Tuple{Vector{Tuple{Int64,Int64}},Int64,Int64}}()
    push!(recherche, (Vector{Tuple{Int64,Int64}}([d]),0,h(d,ar)))
    while (!isempty(recherche) && !(arrive))
        cour = recherche[1]
        popfirst!(recherche)
        for a in adj_DT(map, cour[1][end])
            if !(present(visit, a[1]) || a[2] == typemax(Int64))
                inserer(visit, (a[1],cour[2]+a[2]))
                nouv = (copy(cour[1]),cour[2]+a[2],h(a[1],ar))
                push!(nouv[1], a[1])
                ajoutTri(recherche,nouv)
                if (a[1] == ar)
                    sortie = nouv
                    arrive = true
                end
            end
         end
    end
    println("A* : \n",size(visit,1)," états visités")
    if (arrive)
        println(sortie[2], " de distance.")
        return  modifmap(copy(map),sortie[1])
    else 
    	println("Pas de chemin trouvé.")
    	return map
    end 
end
