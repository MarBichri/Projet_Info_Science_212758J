#Calcule le poids de déplacement entre deux cases adjacentes
function dist(map::Matrix{Char}, coordA::Tuple{Int64, Int64}, coordB::Tuple{Int64, Int64})
	if (map[coordB[1],coordB[2]] == '.' || map[coordB[1],coordB[2]] == 'G')
		return 1
	else 
		if (map[coordB[1],coordB[2]] == 'S')
			return 5
		else 
			if (map[coordB[1],coordB[2]] == 'W')
				return 8
			else
				if (map[coordB[1],coordB[2]] == '@' || map[coordB[1],coordB[2]] == 'O' || map[coordB[1],coordB[2]] == 'T')
					return -1
				else
					return 1
				end
			end
		end
	end
end

#Ajoute un chemin dans une liste triée selon la distance traversée
function ajoutTriG(list::Vector{Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}},Int64}}, chem::Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}},Int64})
trouve = false
i = 1
	while (!trouve && i <= size(list,1))
		trouve = (list[i][3] > chem[3])
		
		i+=1
		
	end
	
	if (trouve)
	insert!(list,i-1,chem)
	else
	push!(list,chem)
	end
end

#Algorithme principal
function dijkstra(map::Matrix{Char}, d::Tuple{Int64,Int64}, ar::Tuple{Int64,Int64})
	visites::Set{Tuple{Int64,Int64}} = Set{Tuple{Int64,Int64}}()
	push!(visites,d)
	chemins::Vector{Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}},Int64}} = [(d,[d],0)]
	while !isempty(chemins)
		cour = popfirst!(chemins)
		for a in adj_FF(map, cour[1])
		car = map[a[1],a[2]]
			if !(a in visites || car == '@' || car == 'O' || car == 'T')
				push!(visites, a)
				ajoutTriG(chemins,(a,vcat(cour[2],a),cour[3]+dist(map,cour[1],a)))
				if (a == ar)
					println("Dijsktra : \n", length(visites)," états visités")
					newmap = modifmap2(copy(map), visites)
					return modifmap(newmap,vcat(cour[2],a))
				end
			end
		end
	end
	println("Dijkstra : \n", length(visites)," états visités")
	return map
	
end
