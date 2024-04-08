import SwiftUI
import SDWebImageSwiftUI

struct PokemonRowView: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            Text(pokemon.name)
                .textCase(.uppercase)
                .font(.headline)
            Spacer()
            if let idString = pokemon.url.split(separator: "/").last, let pokemonId = Int(idString) {
                let imageUrlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png"
                if let imageUrl = URL(string: imageUrlString) {
                    WebImage(url: imageUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                }
            } else {
                Text("Image not available")
            }
        }
    }
}
