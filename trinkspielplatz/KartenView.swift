//
//  HoeherTiefer.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 08.01.22.
//

import SwiftUI


struct KartenView: View {
    let gui = Gui()
    @State private var showAnleitung = false
    @State var nKarten = 0
    @State var visibleTrinkzahl: Bool = false
    @State var randomTrinkzahl: Int = 0
    @State var settings: Bool = false
    @State var random: [Card] = DataLoader().cardArray.shuffled()
    
    @State private var openAlert = false
    @State private var herz: Bool = true
    @State private var kreuz: Bool = true
    @State private var karo: Bool = true
    @State private var pik: Bool = true
    @State private var twoToSix: Bool = true
    @State private var sevenToTen: Bool = true
    @State private var bubeToAss: Bool = true
    
    
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
                            ZStack{
                                VStack{
                                    HStack() {
                                        Button(action: {
                                            if visibleTrinkzahl == false {
                                                withAnimation(.spring()) {
                                                    visibleTrinkzahl = true
                                                    randomTrinkzahl = Int.random(in: 3...7)
                                                }
                                            }
                                        }) {
                                            Image("biericon")
                                                .resizable()
                                                .frame(width: geo.size.width * 0.08, height: geo.size.width * 0.08)
                                                .padding(.all, 5.0)
                                        }
                                        .buttonStyle(ThreeD())
                                        .frame(width: geo.size.width * 0.08, height: geo.size.width * 0.08)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            withAnimation(.spring()) {
                                                settings = true
                                            }
                                        }) {
                                            Image(systemName: "gear")
                                                .fontWeight(.semibold)
                                                .font(.title)
                                                .padding(.all, 2.0)
                                        }
                                        .buttonStyle(ThreeD())
                                        .frame(width: geo.size.width * 0.08, height: geo.size.width * 0.08)
                                    }
                                    .padding(.all, 10.0)
                                    .padding(.horizontal, 15.0)
                                    .padding(.bottom)
                                    .frame(width: geo.size.width)
                                    
                                    
                                    Text("Verbleibende Karten: \(random.count - 1 - nKarten)")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.black)
                                        

                                    Spacer()

                                    Image("png/\(random[safe: nKarten]?.card ?? "png/herz2")")
                                        .resizable()
                                        .shadow(radius: 10)
                                        .frame(width: geo.size.width * 0.50, height: geo.size.width * 0.70)

                                    Spacer()

                                    Button(action: {
                                        if nKarten == random.count - 1 {
                                            random = random.shuffled()
                                            nKarten = 0
                                        }
                                        else {
                                            nKarten += 1
                                        }
                                    })
                                    {
                                        Text(nKarten == random.count - 1 ? "Neu starten" : "Nächste Karte")
                                            .fontWeight(.semibold)
                                            .font(.body)
                                    }
                                    .buttonStyle(ThreeD())
                                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                                    .padding(.top)
                                    
                                }
                                .opacity(settings || visibleTrinkzahl ? 0 : 1)
                                
                                VStack{
                                    ZStack(){
                                        RoundedRectangle(cornerRadius: 25)
                                            .foregroundColor(Color("bluegray"))
                                            .offset(y: 5)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                                    .offset(y: 5)
                                            )
                                        
                                        RoundedRectangle(cornerRadius: 25)
                                            .foregroundColor(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                            )
                                        
                                        VStack {
                                            Spacer()
                                            Text("Kartenauswahl")
                                                .fontWeight(.semibold)
                                                .font(.title3)
                                                .padding()
                                            
                                            
                                            
                                            HStack{
                                                VStack {
                                                    Toggle("Herz", isOn: $herz)
                                                    Toggle("Kreuz", isOn: $kreuz)
                                                    Toggle("Karo", isOn: $karo)
                                                    Toggle("Pik", isOn: $pik)
                                                    Spacer()
                                                }
                                                .frame(width: geo.size.width * 0.3)
                                                
                                                Spacer()
                                                
                                                VStack {
                                                    Toggle("2-6", isOn: $twoToSix)
                                                    Toggle("7-10", isOn: $sevenToTen)
                                                    Toggle("Bube-Ass", isOn: $bubeToAss)
                                                    Spacer()
                                                }
                                                .frame(width: geo.size.width * 0.40)
                                            }
                                            .padding(.horizontal)
                                            
                                            HStack {
                                                Button(action: {
                                                    if herz && kreuz && karo && pik && twoToSix && sevenToTen && bubeToAss {
                                                        herz = false
                                                        kreuz = false
                                                        karo = false
                                                        pik = false
                                                        twoToSix = false
                                                        sevenToTen = false
                                                        bubeToAss = false
                                                    }
                                                    else {
                                                        herz = true
                                                        kreuz = true
                                                        karo = true
                                                        pik = true
                                                        twoToSix = true
                                                        sevenToTen = true
                                                        bubeToAss = true
                                                    }
                                                })
                                                {
                                                    Text(herz && kreuz && karo && pik && twoToSix && sevenToTen && bubeToAss ? "Aufheben" : "Auswählen")
                                                        .fontWeight(.semibold)
                                                        .font(.body)
                                                }
                                                .buttonStyle(ThreeD())
                                                .frame(width: geo.size.width * 0.40, height: geo.size.height * 0.08)
                                                
                                                Spacer()
                                                
                                                Button(action: {
                                                    if (!herz && !kreuz && !karo && !pik) || (!twoToSix && !sevenToTen && !bubeToAss) {
                                                        openAlert = true
                                                    }
                                                    else {
                                                        withAnimation(.spring()) {
                                                            settings = false
                                                        }
                                                        setKarten()
                                                    }
                                                })
                                                {
                                                    Text("Speichern")
                                                        .fontWeight(.semibold)
                                                        .font(.body)
                                                }
                                                .buttonStyle(ThreeD())
                                                .frame(width: geo.size.width * 0.40, height: geo.size.height * 0.08)
                                                .alert(isPresented: $openAlert){
                                                    Alert(title: Text("Fehlende Auswahl"), message: Text("Wähle von jeder Seite mindestens 1 aus."), dismissButton: .default(Text("Zurück")))
                                                }
                                            }
                                            .padding(.horizontal)
                                            .padding(.bottom)
                                            
                                            Spacer()
                                        }
                                    }
                                    .frame(height: geo.size.height * 0.55)
                                    .padding(.horizontal)
                                    .shadow(radius: 5, y: 4)
                                    
                                }
                                .opacity(settings && !visibleTrinkzahl ? 1 : 0)
                               
                                VStack(){
                                    Spacer()
                                    ZStack(){
                                        RoundedRectangle(cornerRadius: 25)
                                            .foregroundColor(Color("bluegray"))
                                            .offset(y: 5)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                                    .offset(y: 5)
                                            )
                                        
                                        RoundedRectangle(cornerRadius: 25)
                                            .foregroundColor(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                            )
                                        
                                        VStack {
                                            Spacer()
                                            Text("Trinke \(randomTrinkzahl) Schluck/e!")
                                                .fontWeight(.semibold)
                                                .font(.title)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                    .frame(height: geo.size.height * 0.5)
                                    .padding(.horizontal)
                                    .shadow(radius: 5, y: 4)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        visibleTrinkzahl = false
                                    })
                                    {
                                        Text("Schließen")
                                            .fontWeight(.semibold)
                                            .font(.body)
                                    }
                                    .buttonStyle(ThreeD())
                                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                                }
                                .opacity(visibleTrinkzahl && !settings ? 1 : 0)
                               
                            }
                            .frame(height: geo.size.height * 0.94)
                            .padding(.horizontal)
                        )
                }
            }
            .padding(.all, 10.0)
            
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
        .navigationBarTitle("Karten")
    }
    
    func setKarten() {
        random = DataLoader().cardArray
        if !herz {
            random.removeAll(where: { $0.zeichen == "herz" })
        }
        if !kreuz {
            random.removeAll(where: { $0.zeichen == "kreuz" })
        }
        if !karo {
            random.removeAll(where: { $0.zeichen == "karo" })
        }
        if !pik {
            random.removeAll(where: { $0.zeichen == "pik" })
        }
        if !twoToSix {
            random.removeAll(where: { $0.value <= 6  })
        }
        if !sevenToTen {
            random.removeAll(where: { $0.value > 6 && $0.value <= 10  })
        }
        if !bubeToAss {
            random.removeAll(where: { $0.value >= 11  })
        }
        random = random.shuffled()
        nKarten = 0
    }
    
}

struct KartenView_Previews: PreviewProvider {
    static var previews: some View {
        KartenView()
    }
}
