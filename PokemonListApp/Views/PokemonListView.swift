import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    List {
                        ForEach(viewModel.pokemons, id: \.name) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonRowView(pokemon: pokemon)
                            }
                        }
                        .onDelete(perform: viewModel.deleteItems)
                        .onMove(perform: viewModel.move)
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
            viewModel.fetchData()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
