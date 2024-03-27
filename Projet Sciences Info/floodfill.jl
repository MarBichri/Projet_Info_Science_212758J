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

#Algorithme principal
function floodfill(map::Matrix{Char}, d::Tuple{Int64,Int64}, ar::Tuple{Int64,Int64})
	visites::Set{Tuple{Int64,Int64}} = Set{Tuple{Int64,Int64}}()
	push!(visites,d)
	chemins::Vector{Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}}}} = [(d,[d])]
	while !isempty(chemins)
		cour = popfirst!(chemins)
		for a in adj_FF(map, cour[1])
		car = map[a[1],a[2]]
			if !(a in visites || car == '@' || car == 'O' || car == 'T')
				push!(visites, a)
				push!(chemins,(a,vcat(cour[2],a)))
				if (a == ar)
					println("Floodfill : \n", length(visites)," états visités")
					newmap = modifmap2(copy(map), visites)
					return modifmap(newmap,vcat(cour[2],a))
				end
			end
		end
	end
	println("Floodfill : \n", length(visites)," états visités")
	return map
	
end
