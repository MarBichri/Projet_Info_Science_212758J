# Récupère le chemin vers un fichier map et le convertit en matrice
function parseMap(fichier::String)
    contenu = read(fichier, String)
    lignes = split(contenu, '\n')
    h = parse(Int64, split(lignes[2], ' ')[2])
    w = parse(Int64, split(lignes[3], ' ')[2])
    map = Matrix{Char}(undef, h, w)

    for i in 1:h
        for j in 1:w
            map[i,j] = lignes[i+4][j]
        end
    end

    return map
end

# Modifie une matrice carte pour y include le chemin emprunté
function modifmap(map::Matrix{Char}, chemin::Vector{Tuple{Int64,Int64}})
    for e in chemin
        map[e[1],e[2]] = '*'
    end
    return map
end
