import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false
    
    
    func deleteItems(at offsets: IndexSet) {
        pokemons.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int){
        pokemons.move(fromOffsets: source, toOffset: destination)
    }
    
    func fetchData() {
        isLoading = true
        NetworkingManager.shared.fetchData(from: "https://pokeapi.co/api/v2/pokemon?limit=40&offset=0") { (result: Result<PokemonsResponse, NetworkError>) in
            DispatchQueue.main.async { [self] in
                isLoading = false
                
                switch result {
                case .success(let pokemonsResponse):
                    pokemons = pokemonsResponse.results
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    
}
