import SwiftUI

struct PokemonsResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
}

extension Pokemon {
    var imageUrl: URL? {
        guard let idString = url.split(separator: "/").last,
              let id = Int(idString) else {
            return nil
        }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}


struct PokemonDetailsResponse: Codable {
    let abilities: [Ability]
}

struct Ability: Codable {
    let ability: AbilityDetails
}

struct AbilityDetails: Codable {
    let name: String
    let url: String
}
