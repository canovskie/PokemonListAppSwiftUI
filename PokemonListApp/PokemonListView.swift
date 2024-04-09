import SwiftUI

struct PokemonListView: View {
    @State private var pokemons: [Pokemon] = []
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    List {
                        ForEach(pokemons, id: \.name) { pokemon in
                            NavigationLink(destination: DetailView(pokemon: pokemon)) {
                                PokemonRowView(pokemon: pokemon)
                            }
                        }
                        .onDelete(perform: deleteItems)
                        .onMove(perform: move)
                    }
                    .listStyle(PlainListStyle())
                    .toolbar {
                                            ToolbarItem(placement: .navigationBarLeading) {
                                                EditButton()
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
    
    private func deleteItems(at offsets: IndexSet) {
        pokemons.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int){
        pokemons.move(fromOffsets: source, toOffset: destination)
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
