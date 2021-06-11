//
//  StarshipServiceResponse.swift
//  SwiftUI3Test
//
//  Created by David Fekke on 6/10/21.
//

import Foundation

struct StarshipServiceResponse : Codable {
    let count : Int?
    let next : String?
    let previous : String?
    let results : [Starship]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        previous = try values.decodeIfPresent(String.self, forKey: .previous)
        results = try values.decodeIfPresent([Starship].self, forKey: .results)
    }

}
