import SwiftUI
import SDWebImageSwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel
    
    init(pokemon: Pokemon) {
        self._viewModel = StateObject(wrappedValue: PokemonDetailViewModel(pokemon: pokemon))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.pokemon.name)
                .font(.largeTitle)
                .fontWeight(.black)
                .textCase(.uppercase)
            
            if let idString = viewModel.pokemon.url.split(separator: "/").last, let pokemonId = Int(idString) {
                let imageUrlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png"
                
                if let imageUrl = URL(string: imageUrlString) {
                    WebImage(url: imageUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                }
            } else {
                Text("Image not available")
            }
            
            if !viewModel.abilities.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Abilities:")
                        .font(.headline)
                    List {
                        ForEach(viewModel.abilities, id: \.self) { ability in
                            Text(ability)
                                .textCase(.uppercase)
                        }
                    }.listStyle(.inset)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchAbilities()
        }
    }
}
