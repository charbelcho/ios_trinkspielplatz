//
//  HoeherTiefer.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 08.01.22.
//

import SwiftUI

struct ShitheadView: View {
    let gui = Gui()
    @State private var showAnleitung = false
    @State var n = -1
    @State var text = ""
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
                               
                                Text(text)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .font(.title2)
                                    .lineLimit(2)
                                
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
                            }
                            .frame(height: geo.size.height * 0.93)
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
        .navigationBarItems(trailing: Button(action: {
            showAnleitung = true
        }) {
            Image(systemName: "info.circle")
               .foregroundColor(.black)
        })
        .navigationBarTitle("Captain Shithead")
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
        if random[n].colour == "rot" && between(start: 0, value: random[n].value, end: 11)  {
            text = "Verteile \(random[n].value) Schlucke\n"
        }
        else if random[n].colour == "schwarz" && between(start: 0, value: random[n].value, end: 11)  {
            text = "Trinke \(random[n].value) Schlucke\n"
        }
        else if random[n].value == 11 {
            text = "Alle Männer trinken\n5 Schlucke"
        }
        else if random[n].value == 12 {
            text = "Alle Frauen trinken\n5 Schlucke"
        }
        else if random[n].value == 13 {
            text = "Du bist Captain Shithead\n"
        }
        else if random[n].value == 14 {
            text = "Du bist vor Captain\nShithead geschützt"
        }
        else {
            text = ""
        }
        return text
    }
}

struct ShitheadView_Previews: PreviewProvider {
    static var previews: some View {
        ShitheadView()
    }
}
