import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    var pokemon: Pokemon
    @State private var abilities: [String] = []
    
    var body: some View {
        VStack {
            
            Text(pokemon.name)
                .font(.largeTitle)
                .fontWeight(.black)
                .textCase(.uppercase)
            
            Spacer()
            
            if let idString = pokemon.url.split(separator: "/").last, let pokemonId = Int(idString) {
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
            
            if !abilities.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Abilities:")
                        .font(.headline)
                    List {
                        ForEach(abilities, id: \.self) { ability in
                            Text(ability)
                                .textCase(.uppercase)
                        }
                    }.listStyle(.plain)
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            fetchAbilities()
        }
    }
    
    func fetchAbilities() {
        guard let idString = pokemon.url.split(separator: "/").last, let pokemonId = Int(idString) else {
            return
        }
        let abilitiesURLString = "https://pokeapi.co/api/v2/pokemon/\(pokemonId)/"
        
        NetworkingManager.shared.fetchData(from: abilitiesURLString) { (result: Result<PokemonDetailsResponse, NetworkError>) in
            switch result {
            case .success(let detailsResponse):
                let abilities = detailsResponse.abilities.map { $0.ability.name }
                DispatchQueue.main.async {
                    self.abilities = abilities
                }
            case .failure(let error):
                print("Failed to fetch abilities: \(error)")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let examplePokemon = Pokemon(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")
        return DetailView(pokemon: examplePokemon)
    }
}
