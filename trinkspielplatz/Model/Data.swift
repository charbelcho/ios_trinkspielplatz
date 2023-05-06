//
//  NochnieData.swift
//  NochnieData
//
//  Created by Charbel Chougourou on 19.08.21.
//

import Foundation

struct NochnieData: Codable {
    var text: String
}

struct EherData: Codable {
    var text: String
}

struct PflichtData: Codable {
    var text: String
}

struct WahrheitData: Codable {
    var text: String
}

struct Room {
    var roomId: String
    var users: [User]
}

struct RoomBusfahrer {
    var roomId: String
    var deck: [Card]
    var users: [UserBusfahrer]
    var phase: Int
}

struct User: Hashable {
    var id, username: String
    var werbinich: WerBinIch
}

struct UserBusfahrer: Equatable {
    static func == (lhs: UserBusfahrer, rhs: UserBusfahrer) -> Bool {
        return lhs.id == rhs.id && lhs.username == rhs.username
    }
    
    var id, username: String
    var eigeneKarten: [Int]
    var flipArray: [Bool]
}

struct WerBinIch: Hashable {
    var id: Int
    var text, info: String
}
