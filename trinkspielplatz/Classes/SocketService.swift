//
//  SocketService.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 04.05.23.
//

import Foundation
import SocketIO
import SwiftUI

final class ServiceWerbinich: ObservableObject {
    private var manager = SocketManager(socketURL: URL(string: "wss://socket-ios-backend.herokuapp.com")!, config: [.log(true), .compress])
//    private var manager = SocketManager(socketURL: URL(string: "ws://localhost:8000")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    @Published var isLoading = true
    @Published var connectedToSocket: Bool = false
    @Published var openAlert: Bool = false
    @Published var keinRaumGefunden: Bool = false
    @Published var raumVoll: Bool = false
    @Published var nameBesetzt: Bool = false
    
    @Published var werbinichUsername = ""
    @Published var ausgewaehlt: Bool = false
    @Published var raumIdWerbinich = ""
    @Published var socketData: SocketData = []
    
    @Published var room = Room(roomId: "", users: [])
    @Published var user = User(id: "", username: "", werbinich: WerBinIch(id: 0, text: "", info: ""))
    
    @Published var werbinich = WerBinIch(id: 0, text: "", info: "")
    @Published var speichernFuerUsername = ""
    
    @Published var random: [Card] = DataLoader().cardArray.shuffled()
    var array: [Card] =  DataLoader().cardArray
    
    let durationAndDelay : CGFloat = 0.1
    
    
    init() {
        socket = manager.defaultSocket
        addHandlers()
    }
    
    func addHandlers() {
        socket.on("connected") { [weak self] (data, ack)  in
            self?.connectedToSocket = true
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("werbinIchUsername") { [weak self] (data, ack)  in
            self?.werbinichUsername = data[0] as! String
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("room") { [weak self] (data, ack) in
            if let data = data[0] as? NSDictionary,
               let dataRoomId = data["roomId"],
               let dataUsers = data["users"] as? NSArray {
                self?.room.roomId = dataRoomId as! String
                self?.room.users = []
                for i in 0...dataUsers.count - 1 {
                    let dataUser = dataUsers[i] as! NSDictionary
                    let dataUserWerBinIch = dataUser["werbinich"] as! NSDictionary
                    let newUser = User(
                        id: dataUser["id"] as! String,
                        username: dataUser["username"] as! String,
                        werbinich: WerBinIch(
                            id: dataUserWerBinIch["id"] as! Int,
                            text: dataUserWerBinIch["text"] as! String,
                            info: dataUserWerBinIch["info"] as! String
                        )
                    )
                    self?.room.users.append(newUser)
                }
            }
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("keinRaumGefunden") { [weak self] (data, ack) in
            self?.keinRaumGefunden = true
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("roomFull") { [weak self] (data, ack) in
            self?.raumVoll = true
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("nameBesetzt") { [weak self] (data, ack) in
            self?.nameBesetzt = true
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("speicherNamenFuer") { [weak self] (data, ack) in
            self?.speichernFuerUsername = self?.room.users[data[0] as! Int].username ?? ""
            self?.ausgewaehlt = true
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("loading") { [weak self] (data, ack) in
            withAnimation(.spring()){
                self?.isLoading = true
            }
        }
        
    }
    
    func connectToSocket() {
        socket.connect()
    }
    
    func disconnectFromSocket() {
        socket.disconnect()
        connectedToSocket = false
    }
    
    func usernameWerbinIch(socketData: SocketData) {
        socket.emit("usernameWerbinIch", socketData)
    }
    
    func leaveRoom(socketData: SocketData) {
        socket.emit("leave", socketData)
        withAnimation(.spring()) {
            isLoading = false
        }
    }
    
    func createRoom(socketData: SocketData) {
        socket.emit("createRoom", socketData)
    }
    
    func joinRoom(socketData: SocketData) {
        socket.emit("joinRoom", socketData)
    }
    
    func auswaehlen(socketData: SocketData) {
        socket.emit("auswaehlen", socketData)
    }
    
    func zuweisen(socketData: SocketData) {
        socket.emit("zuweisen", socketData)
    }
    
    func namenSpeichern(socketData: SocketData) {
        socket.emit("namenSpeichern", socketData)
    }
}

final class ServiceBusfahrer: ObservableObject {
    private var manager = SocketManager(socketURL: URL(string: "wss://socket-ios-backend-busfahrer.herokuapp.com")!, config: [.log(true), .compress])
//    private var manager = SocketManager(socketURL: URL(string: "ws://localhost:8001")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    @Published var isLoading: Bool = false
    @Published var connectedToSocket: Bool = false
    @Published var socketData: SocketData = []
    
    @Published var keinRaumGefundenBusfahrer: Bool = false
    @Published var raumVollBusfahrer: Bool = false
    @Published var nameBesetztBusfahrer: Bool = false
    @Published var busfahrerUsername = ""
    @Published var roomBusfahrer = RoomBusfahrer(roomId: "", deck: [], users: [], phase: 1)
    @Published var userBusfahrer = UserBusfahrer(id: "", username: "", eigeneKarten: [], flipArray: [false, false, false])
    
    @Published var meineKarten: [Int] = [Int]()
    
    @Published var fDegreeArray = [-90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0]
    @Published var bDegreeArray = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @Published var flipArray = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    @Published var myCardsFDegreeArray = [0.0, 0.0, 0.0]
    @Published var myCardsBDegreeArray = [90.0, 90.0, 90.0]
    @Published var myCardsFlipArray = [false, false, false]
    @Published var trinkAnzahlArray = [0, 0 ,0]
    @Published var spielername = ""
    @Published var raumIdBusfahrer = ""
    @Published var busfahrer = ""
    @Published var openAlertBusfahrer: Bool = false

    
    @Published var random: [Card] = DataLoader().cardArray.shuffled()
    var array: [Card] =  DataLoader().cardArray
    
    let durationAndDelay : CGFloat = 0.5
    
    
    init() {
        socket = manager.defaultSocket
        addHandlers()
    }
    
    func addHandlers() {
        socket.on("connected") { [weak self] (data, ack)  in
            self?.connectedToSocket = true
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("busfahrerUsername") { [weak self] (data, ack)  in
            withAnimation(.spring()) {
                self?.busfahrerUsername = data[0] as! String
                self?.spielername = data[0] as! String
                self?.isLoading = false
            }
        }
        
        socket.on("roomBusfahrer") { [weak self] (data, ack) in
            if let data = data[0] as? NSDictionary,
               let dataRoomId = data["roomId"],
               let dataPhase = data["phase"],
               let dataUsers = data["users"] as? NSArray {
                withAnimation(.spring()) {
                    self?.roomBusfahrer.roomId = dataRoomId as! String
                }
                let dataDeck = data["deck"] as? NSArray ?? []
                if dataDeck != [] {
                    self?.roomBusfahrer.deck = [Card]()
                    for i in 0...dataDeck.count - 1 {
                        let dataCard = dataDeck[i] as! NSDictionary
                        let card = Card(
                            id: dataCard["id"] as! Int,
                            card: dataCard["card"] as! String,
                            value: dataCard["value"] as! Int,
                            colour: dataCard["colour"] as! String,
                            zeichen: dataCard["zeichen"] as! String
                        )
                        self?.roomBusfahrer.deck.append(card)
                    }
                }
                withAnimation(.spring()) {
                    self?.roomBusfahrer.phase = dataPhase as! Int
                }
                self?.roomBusfahrer.users = []
                for i in 0...dataUsers.count - 1 {
                    let dataUser = dataUsers[i] as! NSDictionary
                    let newUser = UserBusfahrer(
                        id: dataUser["id"] as! String,
                        username: dataUser["username"] as! String,
                        eigeneKarten: dataUser["karten"] as! [Int],
                        flipArray: dataUser["flipArray"] as! [Bool]
                    )
                    withAnimation(.spring()) {
                        self?.roomBusfahrer.users.append(newUser)
                    }
                }
            }
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("keinRaumGefundenBusfahrer") { [weak self] (data, ack) in
            self?.keinRaumGefundenBusfahrer = true
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("roomFullBusfahrer") { [weak self] (data, ack) in
            self?.raumVollBusfahrer = true
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("nameBesetztBusfahrer") { [weak self] (data, ack) in
            self?.nameBesetztBusfahrer = true
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("meineKarten") { [weak self] (data, ack) in
            self?.meineKarten = data[0] as! [Int]
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("gedrehteKarte") { [weak self] (data, ack) in
            if let data = data[0] as? NSDictionary,
               let dataIndex = data["index"] as? Int,
               let dataRow = data["row"] as? Int {
                self?.flipCard(i: dataIndex, row: dataRow)
            }
            withAnimation(.spring()) {
                self?.isLoading = false
            }
        }
        
        socket.on("busfahrerBestimmen") { [weak self] (data, ack) in
            self?.busfahrer = data[0] as! String
            withAnimation(.spring()) {
                self?.openAlertBusfahrer = true
                self?.isLoading = false
            }
        }
        
        socket.on("loading") { [weak self] (data, ack) in
            withAnimation(.spring()){
                self?.isLoading = true
            }
        }
        
    }
    
    func connectToSocket() {
        socket.connect()
    }
    
    func disconnectFromSocket() {
        socket.disconnect()
        connectedToSocket = false
    }
    
    func usernameBusfahrer(socketData: SocketData) {
        socket.emit("usernameBusfahrer", socketData)
    }
    
    func joinRoom(socketData: SocketData) {
        socket.emit("joinRoomBusfahrer", socketData)
    }
    
    func leaveRoomBusfahrer(socketData: SocketData) {
        socket.emit("leaveBusfahrer", socketData)
        withAnimation(.spring()) {
            isLoading = false
        }
    }
    
    func createRoomBusfahrer(socketData: SocketData) {
        socket.emit("createRoomBusfahrer", socketData)
    }
    
    func joinRoomBusfahrer(socketData: SocketData) {
        socket.emit("joinRoomBusfahrer", socketData)
    }
    
    func austeilen(socketData: SocketData) {
        socket.emit("austeilen", socketData)
    }
    
    func karteDrehen(socketData: SocketData) {
        socket.emit("karteDrehen", socketData)
    }
    
    func busfahren(socketData: SocketData) {
        socket.emit("busfahren", socketData)
    }
    
    func flipCard(i: Int, row: Int) {
        if flipArray[i] == false {
            if i == 0 {
                flipArray[i] = true
            }
            else if i > 0 && flipArray[safe: i - 1]! {
                withAnimation(.linear(duration: durationAndDelay)) {
                    flipArray[i] = true
                }
            }
        }
        if flipArray[i] {
            withAnimation(.linear(duration: durationAndDelay)) {
                bDegreeArray[i] = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                fDegreeArray[i] = 0
            }
        }
        checkIfValueInMyCards(value: self.roomBusfahrer.deck[i].value, row: row)
    }
    
    func checkIfValueInMyCards(value: Int, row: Int) {
        for i in 0..<meineKarten.count {
            if self.roomBusfahrer.deck[meineKarten[i]].value == value {
                myCardsFlipArray[i] = true
                if trinkAnzahlArray[i] == 0 {
                    trinkAnzahlArray[i] = row
                }
            }
            if myCardsFlipArray[i] {
                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                    myCardsBDegreeArray[i] = 0
                }
                withAnimation(.linear(duration: durationAndDelay)){
                    myCardsFDegreeArray[i] = -90
                }
            }
        }
    }
    
    func resetGameInfo() {
        withAnimation(.spring()) {
            fDegreeArray = [-90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0]
            bDegreeArray = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
            flipArray = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
            myCardsFDegreeArray = [0.0, 0.0, 0.0]
            myCardsBDegreeArray = [90.0, 90.0, 90.0]
            myCardsFlipArray = [false, false, false]
            trinkAnzahlArray = [0, 0 ,0]
            busfahrer = ""
        }
    }
}

