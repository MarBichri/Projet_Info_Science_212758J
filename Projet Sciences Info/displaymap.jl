using Images, Colors, ImageView

# Convertit les caractères de la matrice en leur couleur correspondante
function charToPixel(c::Char)
if (c == '.' || c == 'G')
		return RGB(1.0,1.0,1.0)
	else 
		if (c == 'S')
			return RGB(1.0,0.5,0.0)
		else 
			if (c == 'W')
				return RGB(0.0,0.0,1.0)
			else
				if (c == '@' || c == 'O')
					return RGB(0.0,0.0,0.0)
				else
					if (c == 'T')
						return RGB(0.0,1.0,0.0)
					else
					
						if (c == 'V')
							return RGB(1.0,0.75,0.75)
						else
						
							return RGB(1.0,0.0,0.0)
						end
					end
				end
			end
		end
	end
end

#Affiche la carte mise en entrée
function afficher_carte(map::Matrix{Char}, nom::String)
    img = Matrix{RGB{Float64}}(undef, size(map,1), size(map,2))

    for i in 1:size(map,1)
        for j in 1:size(map,2)
            img[i,j] = charToPixel(map[i,j])
        end
    end
    
    Images.save(string("Map/",nom,".png"),img)
    ImageView.imshow(img, axes=(1,2), name=nom)
end
