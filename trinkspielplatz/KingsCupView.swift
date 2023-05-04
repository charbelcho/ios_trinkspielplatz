//
//  KingsCupView.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 20.04.23.
//

import SwiftUI

struct KingsCupView: View {
    let gui = Gui()
    @State private var showAnleitung = false
    @State var n = -1
    @State var text = ""
    @State var openAlert = false
    @State var openWasserfallAlert = false
    @State var randomTrinkzahl: Int = 0
    @State var alertText = "Setzt alle zum Trinken an. Es darf erst abgesetzt werden, wenn der rechte Sitznachbar abgesetzt hat. Wer dass Ass gezogen hat, darf zuerst absetzen"
    
    var array = DataLoader().cardArray
    @State var random: [Card] = DataLoader().cardArray.shuffled()
    
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
                                Text("Verbleibende Karten: \(51 - n)")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.black)
                                
                                Spacer(minLength: 30.0)

                                ZStack {
                                    if n < 50 {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color("gray"))
                                            .offset(x: 6, y: 6)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                                    .offset(x: 6, y: 6)
                                            )
                                            .frame(width: geo.size.width * 0.50, height: geo.size.width * 0.70)
                                            .shadow(radius: 5, y: 4)
                                    }
                                    
                                    if n < 51 {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color("gray"))
                                            .offset(x: 3, y: 3)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                                    .offset(x: 3, y: 3)
                                            )
                                            .frame(width: geo.size.width * 0.50, height: geo.size.width * 0.70)
                                            .shadow(radius: n == 50 ? 5 : 0, y: n == 50 ? 4 : 0)
                                    }
                                    Image(n == -1 ? "png/back2" : "png/\(random[n].card)")
                                        .resizable()
                                        .frame(width: geo.size.width * 0.50, height: geo.size.width * 0.70)
                                        .shadow(radius: n == 51 ? 5 : 0, y: n == 51 ? 4 : 0)
                                }
                                
                                Spacer()
                                
                                HStack(alignment: .top) {
                                    Text(text)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.black)
                                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                        .font(.title3)
                                        .lineLimit(3)
                                    
                                    if n >= 0 && random[n].value == 14 {
                                        Button(action: {
                                            openWasserfallAlert = true
                                        }) {
                                            Image(systemName: "info.circle")
                                                .foregroundColor(.black)
                                        }
                                        .padding(.top)
                                        .alert(isPresented: $openWasserfallAlert){
                                            Alert(title: Text("Erklärung"), message: Text(alertText), dismissButton: .default(Text("Verstanden!")))
                                        }
                                    }
                                }
                                
                                
                                Spacer()
                                
                                Button(action: {
                                    if n == 51 {
                                        random = array.shuffled()
                                        withAnimation(.spring()) {
                                            n = 0
                                        }
                                    }
                                    else {
                                        withAnimation(.spring()) {
                                            n += 1
                                            text = setText()
                                        }
                                    }
                                }) {
                                    Text(n == 51 ? "Neu starten" : "Nächste Karte")
                                        .fontWeight(.semibold)
                                        .font(.body)
                                }
                                .buttonStyle(ThreeD())
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                                .alert(isPresented: $openAlert){
                                    Alert(title: Text("Spielstart"), message: Text("Ihr braucht zum Spielen ein weiteres Glas als King's Cup"), dismissButton: .default(Text("Start")))
                                }
                            }
                            .frame(height: geo.size.height * 0.94)
                        )
                }
            }
            .padding(.all, 10.0)
            
            BannerAdView()
        }
        .onAppear(perform: {
            openAlert = true
        })
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
        .navigationBarTitle("King's Cup")
    }
    
    func between(start: Int, value: Int, end: Int) -> Bool {
        if start < value && value < end {
            return true
        }
        else {
            return false
        }
    }
    
    func setText() -> String {
        randomTrinkzahl = Int.random(in: 2...7)
        
        if random[n].value == 2 {
            text = "Verteile \(randomTrinkzahl) Schlucke\n\n"
        }
        else if random[n].value == 3 {
            text = "Trinke \(randomTrinkzahl) Schlucke\n\n"
        }
        else if random[n].value == 4 {
            text = "Wer zuletzt den Boden berührt,\ntrinkt \(randomTrinkzahl) Schlucke\n"
        }
        else if random[n].value == 5 {
            text = "Wer zuletzt den Boden Daumen auf den Tisch legt, trinkt \(randomTrinkzahl) Schlucke\n"
        }
        else if random[n].value == 6 {
            text = "Alle Frauen trinken \(randomTrinkzahl) Schlucke\n\n"
        }
        else if random[n].value == 7 {
            text = "Wer zuletzt die Hand hebt,\ntrinkt \(randomTrinkzahl) Schlucke\n"
        }
        else if random[n].value == 8 {
            text = "Wähle einen Trinkpartner, er/sie trinkt wenn du trinkst\n"
        }
        else if random[n].value == 9 {
            text = "Beginne mit einem Wort, die Mitspieler nennen Reimwörter, der Verlierer tinkt \(randomTrinkzahl) Schlucke\n"
        }
        else if random[n].value == 10 {
            text = "Alle Männer trinken \(randomTrinkzahl) Schlucke\n\n"
        }
        else if random[n].value == 11 {
            text = "Erstelle eine Spielregel, alte Regeln können nicht außer Kraft gesetzt werden\n"
        }
        else if random[n].value == 12 {
            text = "Spielt \"Ich hab noch nie..\"\n\n"
        }
        else if random[n].value == 13 {
            text = "Kippe ein Getränk deiner\nWahl in den King's Cup\n"
        }
        else if random[n].value == 14 {
            text = "Wasserfall\n\n"
        }
        return text
    }
}

struct KingsCupView_Previews: PreviewProvider {
    static var previews: some View {
        KingsCupView()
    }
}
