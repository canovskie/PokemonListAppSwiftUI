import SwiftUI
import SDWebImage

struct PokemonListView: View {
    @State private var pokemons: [Pokemon] = []
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            HStack {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    List(pokemons, id: \.name) { pokemon in
                        NavigationLink(destination: DetailView(pokemon: pokemon)) {
                            PokemonRowView(pokemon: pokemon)
                        }
                    }
                }
            }
            .navigationTitle("Pokemons")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            fetchData()
        }
    }

    private func fetchData() {
        isLoading = true
        NetworkingManager.shared.fetchData(from: "https://pokeapi.co/api/v2/pokemon?limit=40&offset=0") { (result: Result<PokemonsResponse, NetworkError>) in
            DispatchQueue.main.async {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
