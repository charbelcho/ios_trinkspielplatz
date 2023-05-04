//
//  BangView.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 16.06.22.
//

import SwiftUI

struct VerliererModalBangView: View {
    let gui = Gui()
    @Binding var isVerliererModalOpen: Bool
    @Binding var verlierer: Int
    @Binding var randomVerliererTrinkzahl: Int
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
                                    isVerliererModalOpen = false
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
                                Text("Spieler \(verlierer) hat verloren und trinkt \(randomVerliererTrinkzahl) Schluck/e!")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .rotationEffect(.degrees(180))
                                
                                
                                Divider()
                                
                                
                                Text("Spieler \(verlierer) hat verloren und trinkt \(randomVerliererTrinkzahl) Schluck/e!")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                
                                Spacer()
                                
                                Text("Spieler 2")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                
                                Button(action: {
                                    isVerliererModalOpen = false
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
        .padding(.all, 10.0)
        .background(Color("bluegray"))
    }
}

struct VerliererModalBangView_Previews: PreviewProvider {
    static var previews: some View {
        VerliererModalBangView(isVerliererModalOpen: .constant(false), verlierer: .constant(1), randomVerliererTrinkzahl: .constant(1), buttonVisible: .constant(false))
    }
}
