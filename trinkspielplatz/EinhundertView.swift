//
//  HoeherTiefer.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 08.01.22.
//

import SwiftUI

class Spieler100: Spieler {
    @Published var items = [Spieler100]()
    @Published var punkte: Int
    
    init(name: String, punkte: Int) {
        self.items = []
        self.punkte = punkte
        super.init(name: name)
    }
}

struct EinhundertView: View {
    @ObservedObject var spieler = Spieler100(name: "", punkte: 0)
    let gui = Gui()
    @State private var showAnleitung = false
    @State var n = 0
    @State var punkteStart: Int = 0
    @State var punkteEnde: Int = 0

    @State var isStartModalOpen: Bool = true
    @State var textVisible: Bool = false
    @State var openAlert: Bool = false
    @State var randomTrinkzahl: Int = 0
    @State var filteredWinner: [Spieler100] = []
    @State var filteredLoser: [Spieler100] = []
    
    @State private var rolling: Bool = false
    @State private var naechsterSpieler: Bool = false
    @State private var value: Int = 1
    @State private var scale: CGFloat = 1
    @State private var angle: Double = 0
    
    let duration = 0.05
    @State var delayDouble = 0.0
    
    
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
                                HStack {
                                    VStack(alignment: .leading){
                                        Text("Am Zug:")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                        Text("\(spieler.items[safe: n]?.name ?? "")")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                    }

                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text("Punkte:")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                        Text("\(spieler.items[safe: n]?.punkte ?? 0)")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                    }
                                }

                                HStack {
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("aktuell:")
                                            .font(.headline)
                                            .fontWeight(.regular)
                                        Text("\(punkteEnde)")
                                            .font(.headline)
                                            .fontWeight(.regular)
                                    }
                                }
                                Spacer()
                                Image("wuerfel-\(value)-black")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: geo.size.width * 0.5)
                                    .rotationEffect(.degrees(angle))
                                    .scaleEffect(scale)
                                    .shadow(radius: 10)
                                    .onTapGesture {
                                        if !rolling && !naechsterSpieler {
                                            rolling = true
                                            textVisible = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                                rolling = false
                                            }
                                            self.angle = 0.0
                                            for i in 0..<55 {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.05) {
                                                    if i < 54 {
                                                        value = 1 + (i % 6)
                                                    }
                                                    else {
                                                        value = Int.random(in: 1...6)
                                                        if value < 6 {
                                                            if value == 1 {
                                                                withAnimation(.spring()) {
                                                                    textVisible = true
                                                                }
                                                                randomTrinkzahl = Int.random(in: 1...5)
                                                            }
                                                            punkteEnde += value
                                                            if punkteEnde >= 100 {
                                                                setWinner(index: n)
                                                            }
                                                        }
                                                        else if value == 6 {
                                                            punkteEnde = spieler.items[safe: n]!.punkte
                                                            withAnimation(.spring()) {
                                                                naechsterSpieler = true
                                                                textVisible = true
                                                            }
                                                            randomTrinkzahl = Int.random(in: 1...5)
                                                        }
                                                    }
                                                }
                                            }
                                            withAnimation(.linear(duration: 1)) {
                                                scale = 1.5
                                            }
                                            withAnimation(.linear(duration: 1).delay(1)) {
                                                scale = 1
                                            }
                                            withAnimation(.spring(response: 1, dampingFraction: 1.5, blendDuration: 3).speed(1.2)) {
                                                angle = 360.0 * 2
                                            }
                                        }
                                    }
                                Spacer()

                                Text(value == 1 ? "Alle außer dir trinken \n\(randomTrinkzahl) Schluck/e!" : "Du (\(spieler.items[safe: n]!.name)) \ntrinkst \(randomTrinkzahl) Schluck/e!")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .opacity(textVisible ? 1 : 0)

                                Spacer()

                                Button(action: {
                                    if !naechsterSpieler {
                                        spieler.items[safe: n]?.punkte = punkteEnde
                                    }
                                    else {
                                        naechsterSpieler = false
                                    }
                                    if n < spieler.items.count - 1 {
                                        n += 1
                                    }
                                    else if n == spieler.items.count - 1 {
                                        n = 0
                                    }
                                    punkteEnde = spieler.items[safe: n]!.punkte
                                    textVisible = false
                                }) {
                                    Text(naechsterSpieler ? "Nächster Spieler" : "Speichern")
                                        .fontWeight(.semibold)
                                        .font(.body)
                                        
                                }
                                .disabled(rolling)
                                .buttonStyle(ThreeD())
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                                .opacity((!rolling && punkteEnde != spieler.items[safe: n]?.punkte) || naechsterSpieler ? 1 : 0)
                                .alert("\(spieler.items[safe: n]?.name ?? "") hat gewonnen!", isPresented: $openAlert){
                                    ForEach(filteredLoser) { item in
                                        Button("\(item.name) hat verloren, trinkt \(randomTrinkzahl) Schluck/e!"){neustart()}
                                    }
                                    Button("Neustart", role: .cancel) {neustart()}
                                }
                            }
                            .frame(height: geo.size.height * 0.95)
                            .padding(.horizontal)
                        )
                }
            }
            .padding(.all, 10.0)
            .fullScreenCover(isPresented: $isStartModalOpen) { StartModalEinhundertView(isStartModalOpen: $isStartModalOpen, spieler: spieler)
            }
            BannerAdView()
        }
        .background(Color("bluegray"))
        .sheet(isPresented: $showAnleitung) {
            AnleitungenView()
        }
        .navigationBarItems(trailing: Button(action: {
                showAnleitung = true
            }) {
                Image(systemName: "info.circle")
                   .foregroundColor(.black)
        })
        .navigationBarTitle("100")
    }
    func setWinner(index: Int) {
        for j in 0...spieler.items.count - 1 {
            if j != n {
                filteredLoser.append(spieler.items[j])
            }
        }
        randomTrinkzahl = Int.random(in: 4...7) * 2
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            openAlert = true
        }
    }

    func neustart() {
        n = 0
        punkteStart = 0
        punkteEnde = 0

        isStartModalOpen = true
        textVisible = false
        openAlert = false
        randomTrinkzahl = 0
        filteredWinner = []
        filteredLoser = []

        rolling = false
        naechsterSpieler = false
    }
}

struct EinhundertView_Previews: PreviewProvider {
    static var previews: some View {
        EinhundertView()
    }
}
