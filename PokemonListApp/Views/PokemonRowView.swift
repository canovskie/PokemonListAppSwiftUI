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
            if let imageUrl = pokemon.imageUrl {
                        WebImage(url: imageUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                    } else {
                        Text("Image not available")
                    }
        }
    }
}
