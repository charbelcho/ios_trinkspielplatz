//
//  Card.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 04.05.23.
//

import Foundation

struct Card: Codable {
    let id: Int
    var card: String
    var value: Int
    var colour: String
    var zeichen: String
}
