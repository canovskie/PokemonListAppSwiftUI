import SwiftUI

struct PokemonsResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
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
