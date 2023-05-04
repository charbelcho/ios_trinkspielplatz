//
//  BangView.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 16.06.22.
//

import SwiftUI

struct ZuFruehModalBangView: View {
    let gui = Gui()
    @Binding var isZuFruehModalOpen: Bool
    @Binding var spielerZuFrueh: Int
    @Binding var randomZuFruehTrinkzahl: Int
    @Binding var buttonVisible: Bool
    
    var body: some View {
        VStack {
            Spacer(minLength: 30.0)
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    Color("bluegray")
                        .ignoresSafeArea(.all, edges: [.bottom, .trailing])
                    RoundedRectangle(cornerRadius: gui.cornerRadius25)
                        .fill(.white)
                        .frame(width: geo.size.width , height: geo.size.height * 0.8)
                        .overlay(
                            VStack() {
                                Button(action: {
                                    isZuFruehModalOpen = false
                                })
                                {
                                    Text("Nochmal")
                                        .fontWeight(.semibold)
                                        .font(.body)
                                        .rotationEffect(.degrees(180))
                                }
                                .buttonStyle(ThreeD180())
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.07)
                                .opacity(buttonVisible ? 1 : 0)
                                
                                Text("Spieler 1")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .rotationEffect(.degrees(180))
                                
                                Spacer()
                                Text("Spieler \(spielerZuFrueh) hat zu früh geschossen und trinkt \(randomZuFruehTrinkzahl) Schluck/e!")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .rotationEffect(.degrees(180))
                                
                                Divider()
                                Text("Spieler \(spielerZuFrueh) hat zu früh geschossen und trinkt \(randomZuFruehTrinkzahl) Schluck/e!")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                
                                Spacer()
                                
                                Text("Spieler 2")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                
                                Button(action: {
                                    isZuFruehModalOpen = false
                                })
                                {
                                    Text("Nochmal")
                                        .fontWeight(.semibold)
                                        .font(.body)
                                }
                                .buttonStyle(ThreeD())
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.07)
                                .opacity(buttonVisible ? 1 : 0)
                            }
                            .frame(height: geo.size.height * 0.73)
                        )
                }
            }
        }
        .padding(.horizontal)
        .background(Color("bluegray"))
        
    }
}

struct ZuFruehModalBangView_Previews: PreviewProvider {
    static var previews: some View {
        ZuFruehModalBangView(isZuFruehModalOpen: .constant(false), spielerZuFrueh: .constant(1), randomZuFruehTrinkzahl: .constant(1), buttonVisible: .constant(false))
    }
}
