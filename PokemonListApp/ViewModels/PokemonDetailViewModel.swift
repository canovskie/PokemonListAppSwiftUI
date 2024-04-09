import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var abilities: [String] = []
    var pokemon: Pokemon
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
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
