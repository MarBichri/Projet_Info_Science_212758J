using Images, Colors, Match

# Convertit les caractères de la matrice en leur couleur correspondante
function charToPixel(c::Char)
    @match c begin
        '.' || 'G' => RGB(1.0,1.0,1.0)
        '@' || 'O' => RGB(0.0,0.0,0.0)
        'T' => RGB(0.0,1.0,0.0)
        'W' => RGB(0.0,0.0,1.0)
        'S' => RGB(1.0,0.5,0.0)
        '*' => RGB(1.0,0.0,0.0)
        'D' => RGB(0.0,0.0,1.0)
        'A' => RGB(1.0,0.0,1.0)
    end
end

# Sauvegarde la carte sous un png
function afficher_carte(map::Matrix{Char}, nom::String)
    img = Matrix{RGB{Float64}}(undef, size(map,1), size(map,2))

    for i in 1:size(map,1)
        for j in 1:size(map,2)
            img[i,j] = charToPixel(map[i,j])
        end
    end
    
    Images.save(nom, img)
end
