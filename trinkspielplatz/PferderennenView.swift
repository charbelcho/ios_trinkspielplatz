//
//  HoeherTiefer.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 08.01.22.
//

import SwiftUI

class Spieler: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name: String
    
    init(name: String) {
        self.name = name
    }
}

class SpielerPferderennen: Spieler {
    @Published var items = [SpielerPferderennen]()
    @Published var schlucke: Int
    @Published var zeichen: String
    
    init(name: String, schlucke: Int, zeichen: String) {
        self.items = []
        self.schlucke = schlucke
        self.zeichen = zeichen
        super.init(name: name)
    }
}

struct PferderennenView: View {
    @ObservedObject var spieler = SpielerPferderennen(name: "", schlucke: 0, zeichen: "")
    let gui = Gui()
    @State private var showAnleitung = false
    
    @State var n = -1
    @State var randomStapel: [Card] = DataLoader().pferderennenCardArray
    @State var randomVerdeckt: [Card] = DataLoader().pferderennenStartCardArray
    var array = DataLoader().pferderennenCardArray
    @State var position0: Int = 0
    @State var position1: Int = 0
    @State var position2: Int = 0
    @State var position3: Int = 0
    @State var position4: Int = 0
    @State var minValue: Int = 0
    @State var turnedArray: [Bool] = [
        false, false, false, false, false, false, false
    ]
    @State var width: CGFloat = 0
    @State var height: CGFloat = 0
    @State var isStartModalOpen: Bool = true
    @State var openAlert: Bool = false
    @State var alert: Int = 0
    @State var alertTitle: String = ""
    @State var randomTrinkzahl: Int = 0
    @State var filteredWinner: [SpielerPferderennen] = []
    @State var filteredLoser: [SpielerPferderennen] = []
    @State var filteredStrafe: [SpielerPferderennen] = []
    
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    Color("bluegray")
                        .ignoresSafeArea(.all, edges: [.bottom, .trailing])
                    RoundedRectangle(cornerRadius: gui.cornerRadius25)
                        .fill(.white)
                        .frame(width: geo.size.width , height: geo.size.height)
                        .overlay(
                            VStack() {
                                HStack() {
                                    VStack() {
                                        Image(turnedArray[6] ? "png/\(randomVerdeckt[6].card)" : "png/back2")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                        Image(turnedArray[5] ? "png/\(randomVerdeckt[5].card)" : "png/back2")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                        Image(turnedArray[4] ? "png/\(randomVerdeckt[4].card)" : "png/back2")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                        Image(turnedArray[3] ? "png/\(randomVerdeckt[3].card)" : "png/back2")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                        Image(turnedArray[2] ? "png/\(randomVerdeckt[2].card)" : "png/back2")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                        Image(turnedArray[1] ? "png/\(randomVerdeckt[1].card)" : "png/back2")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                        Image(turnedArray[0] ? "png/\(randomVerdeckt[0].card)" : "png/back2")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                        Image("png/back2")
                                            .resizable()
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(0.0)
                                    }
                                    Spacer(minLength: 30.0)
                                        
                                    VStack() {
                                        Image("png/herza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position1 == 7 ? 1.0 : 0.0)
                                        Image("png/herza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position1 == 6 ? 1.0 : 0.0)
                                        Image("png/herza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position1 == 5 ? 1.0 : 0.0)
                                        Image("png/herza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position1 == 4 ? 1.0 : 0.0)
                                        Image("png/herza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position1 == 3 ? 1.0 : 0.0)
                                        Image("png/herza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position1 == 2 ? 1.0 : 0.0)
                                        Image("png/herza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position1 == 1 ? 1.0 : 0.0)
                                        Image("png/herza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position1 == 0 ? 1.0 : 0.0)
                                    }
                                    VStack() {
                                        Image("png/kreuza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position2 == 7 ? 1.0 : 0.0)
                                        Image("png/kreuza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position2 == 6 ? 1.0 : 0.0)
                                        Image("png/kreuza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position2 == 5 ? 1.0 : 0.0)
                                        Image("png/kreuza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position2 == 4 ? 1.0 : 0.0)
                                        Image("png/kreuza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position2 == 3 ? 1.0 : 0.0)
                                        Image("png/kreuza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position2 == 2 ? 1.0 : 0.0)
                                        Image("png/kreuza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position2 == 1 ? 1.0 : 0.0)
                                        Image("png/kreuza")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position2 == 0 ? 1.0 : 0.0)
                                    }
                                    VStack() {
                                        Image("png/karoa")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position3 == 7 ? 1.0 : 0.0)
                                        Image("png/karoa")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position3 == 6 ? 1.0 : 0.0)
                                        Image("png/karoa")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position3 == 5 ? 1.0 : 0.0)
                                        Image("png/karoa")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position3 == 4 ? 1.0 : 0.0)
                                        Image("png/karoa")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position3 == 3 ? 1.0 : 0.0)
                                        Image("png/karoa")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position3 == 2 ? 1.0 : 0.0)
                                        Image("png/karoa")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position3 == 1 ? 1.0 : 0.0)
                                        Image("png/karoa")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position3 == 0 ? 1.0 : 0.0)
                                    }
                                    VStack() {
                                        Image("png/pika")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position4 == 7 ? 1.0 : 0.0)
                                        Image("png/pika")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position4 == 6 ? 1.0 : 0.0)
                                        Image("png/pika")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position4 == 5 ? 1.0 : 0.0)
                                        Image("png/pika")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position4 == 4 ? 1.0 : 0.0)
                                        Image("png/pika")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position4 == 3 ? 1.0 : 0.0)
                                        Image("png/pika")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position4 == 2 ? 1.0 : 0.0)
                                        Image("png/pika")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position4 == 1 ? 1.0 : 0.0)
                                        Image("png/pika")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(position4 == 0 ? 1.0 : 0.0)
                                    }
                                    Spacer(minLength: 30.0)
                                    VStack() {
                                        ForEach((1...6), id: \.self) {_ in
                                            Image("png/back2")
                                                .resizable()
                                                .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                                .opacity(0.0)
                                        }
                                        Image(n == -1 ? "png/back2": "png/\(randomStapel[n].card)")
                                            .resizable()
                                            .shadow(radius: 3)
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                        Image("png/back2")
                                            .resizable()
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.15)
                                            .opacity(0.0)
                                    }
                                }
                                .padding(.horizontal)
                                Spacer()
                                VStack {
                                    Button(action: {
                                        if n == 47 {
                                            randomStapel = array.shuffled()
                                            randomVerdeckt = Array(randomStapel[0..<7])
                                            randomStapel.removeFirst(7)
                                            n = -1
                                        }
                                        else {
                                            withAnimation(.spring()) {
                                                n += 1
                                            }
                                            setCards()
                                            checkPosition()
                                        }
                                    }) {
                                        Text(n == 47 ? "Neu starten" : "Nächste Karte")
                                            .fontWeight(.semibold)
                                            .font(.body)
                                    }
                                    .buttonStyle(ThreeD())
                                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                                    .alert(alertTitle, isPresented: $openAlert){
                                        if alert == 1 {
                                            ForEach(filteredWinner) { item in
                                                Button("\(item.name) hat gewonnen, verteilt \(item.schlucke * 2) Schlucke!"){neustart()}
                                            }
                                            ForEach(filteredLoser) { item in
                                                Button("\(item.name) hat verloren, trinkt  \(item.schlucke) Schluck/e!"){neustart()}
                                            }
                                            Button("Neustart", role: .cancel) {neustart()}
                                        }
                                        else if alert == 2 {
                                            ForEach(filteredStrafe) { item in
                                                Button("\(item.name) trinkt \(randomTrinkzahl) Schlucke!"){}
                                            }
                                            Button("Trink!", role: .cancel) { }
                                        }
                                    }
                                }
                            }
                            .frame(height: geo.size.height * 0.92)
                        )
                }
            }
            .padding(.all, 10.0)
            .fullScreenCover(isPresented: $isStartModalOpen) { StartModalPferderennenView(isStartModalOpen: $isStartModalOpen, spieler: spieler)
            }
            BannerAdView()
        }
        .background(Color("bluegray"))
        .sheet(isPresented: $showAnleitung) {
            AnleitungenView()
        }
        .navigationBarItems(trailing:
            Button(action: {
                showAnleitung = true
            }) {
                Image(systemName: "info.circle")
                   .foregroundColor(.black)
        })
        .navigationBarTitle("Pferderennen")
    }
        
    func setCards() {
        let text = randomStapel[n].zeichen
        switch text {
        case "herz":
            withAnimation(.spring()) {
                position1 += 1
            }
        case "kreuz":
            withAnimation(.spring()) {
                position2 += 1
            }
        case "karo":
            withAnimation(.spring()) {
                position3 += 1
            }
        case "pik":
            withAnimation(.spring()) {
                position4 += 1
            }
        default: break
        }
    }
    
    func checkPosition() {
        let positionArray = [position1, position2, position3, position4]
        minValue = positionArray.min()!
        let winner = positionArray.firstIndex(of: 8)
        switch minValue {
        case 1:
            if !turnedArray[0] {
                goBack(x: 0)
                withAnimation(.spring()) {
                    turnedArray[0] = true
                }
            }
        case 2:
            if !turnedArray[1] {
                goBack(x: 1)
                withAnimation(.spring()) {
                    turnedArray[1] = true
                }
            }
        case 3:
            if !turnedArray[2] {
                goBack(x: 2)
                withAnimation(.spring()) {
                    turnedArray[2] = true
                }
            }
        case 4:
            if !turnedArray[3] {
                goBack(x: 3)
                withAnimation(.spring()) {
                    turnedArray[3] = true
                }
            }
        case 5:
            if !turnedArray[4] {
                goBack(x: 4)
                withAnimation(.spring()) {
                    turnedArray[4] = true
                }
            }
        case 6:
            if !turnedArray[5] {
                goBack(x: 5)
                withAnimation(.spring()) {
                    turnedArray[5] = true
                }
            }
        case 7:
            if !turnedArray[6] {
                goBack(x: 6)
                withAnimation(.spring()) {
                    turnedArray[6] = true
                }
            }
        default: break
        }
        
        switch winner {
        case 0:
            filteredWinner = spieler.items.filter { $0.zeichen == "Herz" }
            filteredLoser = spieler.items.filter { $0.zeichen != "Herz" }
            alertTitle = "Herz hat gewonnen!"
            alert = 1
            openAlert = true
        case 1:
            filteredWinner = spieler.items.filter { $0.zeichen == "Kreuz" }
            filteredLoser = spieler.items.filter { $0.zeichen != "Kreuz" }
            alertTitle = "Kreuz hat gewonnen!"
            alert = 1
            openAlert = true
        case 2:
            filteredWinner = spieler.items.filter { $0.zeichen == "Karo" }
            filteredLoser = spieler.items.filter { $0.zeichen != "Karo" }
            alertTitle = "Karo hat gewonnen!"
            alert = 1
            openAlert = true
        case 3:
            filteredWinner = spieler.items.filter { $0.zeichen == "Pik" }
            filteredLoser = spieler.items.filter { $0.zeichen != "Pik" }
            alertTitle = "Pik hat gewonnen!"
            alert = 1
            openAlert = true
        default: break
        }
    }
    
    func goBack(x: Int) {
        let text = randomVerdeckt[x].zeichen
        randomTrinkzahl = Int.random(in: 3...7)
        alertTitle = "Strafe "
        switch text {
        case "herz":
            withAnimation(.spring()) {
                position1 -= 1
            }
            filteredStrafe = spieler.items.filter { $0.zeichen == "Herz" }
            alertTitle = alertTitle + "für Herz"
        case "kreuz":
            withAnimation(.spring()) {
                position2 -= 1
            }
            filteredStrafe = spieler.items.filter { $0.zeichen == "Kreuz" }
            alertTitle = alertTitle + "für Kreuz"
        case "karo":
            withAnimation(.spring()) {
                position3 -= 1
            }
            filteredStrafe = spieler.items.filter { $0.zeichen == "Karo" }
            alertTitle = alertTitle + "für Karo"
        case "pik":
            withAnimation(.spring()) {
                position4 -= 1
            }
            filteredStrafe = spieler.items.filter { $0.zeichen == "Pik" }
            alertTitle = alertTitle + "für Pik"
        default: break
        }
        alert = 2
        openAlert = true
    }
    
    func neustart() {
        n = -1
        randomStapel = array.shuffled()
        randomVerdeckt = Array(randomStapel[0..<7])
        randomStapel.removeFirst(7)
        position0 = 0
        position1 = 0
        position2 = 0
        position3 = 0
        position4 = 0
        minValue = 0
        turnedArray = [
            false, false, false, false, false, false, false
        ]
        isStartModalOpen = true
        openAlert = false
        alert = 0
        alertTitle = ""
        randomTrinkzahl = 0
        filteredWinner = []
        filteredLoser = []
        filteredStrafe = []
    }
}

struct Pferderennen_Previews: PreviewProvider {
    static var previews: some View {
        PferderennenView()
    }
}
