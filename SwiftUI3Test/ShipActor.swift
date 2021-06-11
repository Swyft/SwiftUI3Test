//
//  ShipActor.swift
//  SwiftUI3Test
//
//  Created by David Fekke on 6/11/21.
//

import Foundation


actor ShipActor {
    var starship: Starship
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(ship: Starship, label: String, measurement: Int) {
        self.starship = ship
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
