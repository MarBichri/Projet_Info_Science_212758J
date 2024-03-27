#Retourne la distance heuristique entre deux points
function h(d::Tuple{Int64,Int64}, a::Tuple{Int64, Int64})
	return(abs(d[1] - a[1]) + abs(d[2] - a[2]))
end

#Ajoute un chemin dans une liste triée selon la valeur de sa fonction f
function ajoutTriF(list::Vector{Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}},Int64,Int64}}, chem::Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}},Int64,Int64})
trouve = false
i = 1
	while (!trouve && i <= size(list,1))
		trouve = (list[i][3] + list[i][4] > chem[3] + chem[4])
		
		i+=1
		
	end
	
	if (trouve)
	insert!(list,i-1,chem)
	else
	push!(list,chem)
	end
end

#Algorithme principal
function aStar(map::Matrix{Char}, d::Tuple{Int64,Int64}, ar::Tuple{Int64,Int64})
	visites::Set{Tuple{Int64,Int64}} = Set{Tuple{Int64,Int64}}()
	push!(visites,d)
	chemins::Vector{Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}},Int64,Int64}} = [(d,[d],0,h(d,ar))]
	while !isempty(chemins)
		cour = popfirst!(chemins)
		for a in adj_FF(map, cour[1])
		car = map[a[1],a[2]]
			if !(a in visites || car == '@' || car == 'O' || car == 'T')
				push!(visites, a)
				ajoutTriF(chemins,(a,vcat(cour[2],a),cour[3]+dist(map,cour[1],a), h(a,ar)))
				if (a == ar)
					println("A* : \n", length(visites)," états visités")
					println("distance de ", cour[3])
					newmap = modifmap2(copy(map), visites)
					return modifmap(newmap,vcat(cour[2],a))
				end
			end
		end
	end
	println("A* : \n", length(visites)," états visités")
	return map
	
end
