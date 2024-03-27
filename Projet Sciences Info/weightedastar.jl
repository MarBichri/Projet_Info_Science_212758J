function ajoutTriWeightedF(list::Vector{Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}},Int64,Int64}}, chem::Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}},Int64,Int64}, w::Float64)
trouve = false
i = 1
	while (!trouve && i <= size(list,1))
		trouve = (w*list[i][3] + (1-w)*list[i][4] > w*chem[3] + (1-w)*chem[4])
		
		i+=1
		
	end
	
	if (trouve)
	insert!(list,i-1,chem)
	else
	push!(list,chem)
	end
end

function weightedAStar(map::Matrix{Char}, d::Tuple{Int64,Int64}, ar::Tuple{Int64,Int64}, w::Float64)
	visites::Set{Tuple{Int64,Int64}} = Set{Tuple{Int64,Int64}}()
	push!(visites,d)
	chemins::Vector{Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}},Int64,Int64}} = [(d,[d],0,h(d,ar))]
	while !isempty(chemins)
		cour = popfirst!(chemins)
		for a in adj_FF(map, cour[1])
		car = map[a[1],a[2]]
			if !(a in visites || car == '@' || car == 'O' || car == 'T')
				push!(visites, a)
				ajoutTriWeightedF(chemins,(a,vcat(cour[2],a),cour[3]+dist(map,cour[1],a), h(a,ar)),w)
				if (a == ar)
					println("WA* : \n", length(visites)," états visités")
					println("distance de ", cour[3])
					newmap = modifmap2(copy(map), visites)
					return modifmap(newmap,vcat(cour[2],a))
				end
			end
		end
	end
	println("WA* : \n", length(visites)," états visités")
	return map
	
end

function dynamicWeightedAStar(map::Matrix{Char}, d::Tuple{Int64,Int64}, ar::Tuple{Int64,Int64})
	distIni::Float64 = h(d,ar)
	visites::Set{Tuple{Int64,Int64}} = Set{Tuple{Int64,Int64}}()
	push!(visites,d)
	chemins::Vector{Tuple{Tuple{Int64,Int64},Vector{Tuple{Int64,Int64}},Int64,Int64}} = [(d,[d],0,h(d,ar))]
	while !isempty(chemins)
		cour = popfirst!(chemins)
		for a in adj_FF(map, cour[1])
		car = map[a[1],a[2]]
			if !(a in visites || car == '@' || car == 'O' || car == 'T')
				push!(visites, a)
				ajoutTriWeightedF(chemins,(a,vcat(cour[2],a),cour[3]+dist(map,cour[1],a), h(a,ar)),(max(0,1 - h(a,ar)/distIni) + (dist(map, cour[1],a)-1)/7)/2)
				if (a == ar)
					println("DWA* : \n", length(visites)," états visités")
					println("distance de ", cour[3])
					newmap = modifmap2(copy(map), visites)
					return modifmap(newmap,vcat(cour[2],a))
				end
			end
		end
	end
	println("DWA* : \n", length(visites)," états visités")
	return map
	
end
