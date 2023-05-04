//
//  HoeherTiefer.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 08.01.22.
//

import SwiftUI

struct HoeherTieferView: View {
    let gui = Gui()
    @State private var showAnleitung = false
    @State var n = 0
    @State var correctInRow = 0
    @State var correct = ""
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
                        .frame(width: geo.size.width, height: geo.size.height * 0.9)
                        .overlay(
                            VStack() {
                                Text("Verbleibende Karten: \(51 - n)")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.black)
                                Spacer()
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
                                            .frame(width: geo.size.width * 0.50, height: geo.size.width * 0.65)
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
                                            .frame(width: geo.size.width * 0.50, height: geo.size.width * 0.65)
                                            .shadow(radius: n == 50 ? 5 : 0, y: n == 50 ? 4 : 0)
                                    }
                                    
                                    Image("png/\(random[n].card)")
                                        .resizable()
                                        .frame(width: geo.size.width * 0.50, height: geo.size.width * 0.65)
                                        .shadow(radius: n == 51 ? 5 : 0, y: n == 51 ? 4 : 0)
                                }
                               
                                    
                                
                                Spacer()
                                
                                HStack {
                                    Text(correct == "Richtig" ? "\(correct)" : "Falsch")
                                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                        .background(correct == "Richtig" ? Color.green : Color.red)
                                        .cornerRadius(gui.cornerRadius25)
                                        .font(.body)
                                        .shadow(radius: 10)
                                        .opacity(correct.count > 0 ? 1 : 0)
                                    
                                    Spacer(minLength: 30.0)
                                    Text("Richtig in Folge: \(correctInRow)")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.black)
                                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                        .font(.body)
                                }
                                .padding(.horizontal)
                                
                                Text("Nächster Spieler!")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .font(.body)
                                    .opacity(correctInRow == 3 ? 1 : 0)
                                
                                HStack {
                                    if n == 51 {
                                        Button(action: {
                                            random = array.shuffled()
                                            withAnimation(.spring()) {
                                                n = 0
                                            }
                                        }) {
                                            Text("Neu starten")
//                                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                                .fontWeight(.semibold)
                                                .font(.body)
                                        }
                                        .buttonStyle(ThreeD())
                                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                                    }
                                    else {
                                        Button(action: {
                                            if correctInRow == 3 {
                                                withAnimation(.spring()) {
                                                    correctInRow = 0
                                                }
                                            }
                                            withAnimation(.spring()) {
                                                n += 1
                                            }
                                            if random[n - 1].value < random[n].value {
                                                withAnimation(.spring()) {
                                                    correct = "Richtig"
                                                    correctInRow = correctInRow + 1
                                                }
                                            }
                                            else {
                                                correct = "Falsch!"
                                                withAnimation(.spring()) {
                                                    correctInRow = 0
                                                }
                                            }
                                        }) {
                                            Image(systemName: "arrow.up")
                                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                                                .font(.title3)
                                        }
                                        .buttonStyle(ThreeD())
                                        .frame(width: 80, height: 40)
                                        
                                        Spacer()
                                        Button(action: {
                                            if correctInRow == 3 {
                                                withAnimation(.spring()) {
                                                    correctInRow = 0
                                                }
                                            }
                                            withAnimation(.spring()) {
                                                n += 1
                                            }
                                            if random[n - 1].value == random[n].value {
                                                withAnimation(.spring()) {
                                                    correct = "Richtig"
                                                    correctInRow = correctInRow + 1
                                                }
                                            }
                                            else {
                                                correct = "Falsch!"
                                                withAnimation(.spring()) {
                                                    correctInRow = 0
                                                }
                                            }
                                        }) {
                                            Text("=")
                                                .fontWeight(.semibold)
                                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                                                .font(.title3)
                                        }
                                        .buttonStyle(ThreeD())
                                        .frame(width: 80, height: 40)
                                        
                                        Spacer()
                                        Button(action: {
                                            if correctInRow == 3 {
                                                withAnimation(.spring()) {
                                                    correctInRow = 0
                                                }
                                            }
                                            withAnimation(.spring()) {
                                                n += 1
                                            }
                                            if random[n - 1].value > random[n].value {
                                                withAnimation(.spring()) {
                                                    correct = "Richtig"
                                                    correctInRow = correctInRow + 1
                                                }
                                            }
                                            else {
                                                correct = "Falsch!"
                                                withAnimation(.spring()) {
                                                    correctInRow = 0
                                                }
                                            }
                                        }) {
                                            Image(systemName: "arrow.down")
                                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                                                .font(.title3)
                                        }
                                        .buttonStyle(ThreeD())
                                        .frame(width: 80, height: 40)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                            .frame(height: geo.size.height * 0.85)
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
        .navigationBarTitle("Höher oder Tiefer?")
    }
}

struct HoeherTieferView_Previews: PreviewProvider {
    static var previews: some View {
        HoeherTieferView()
    }
}
