//
//  ContentView2.swift
//  ContentView2
//
//  Created by Charbel Chougourou on 16.08.21.
//

import SwiftUI

struct NochnieView: View {
    let gui = Gui()
    @State private var showAnleitung = false
    var array = DataLoader().nochnieArray
    @State var random: [String] = DataLoader().nochnieArray.shuffled()
    @State var n = 0
    
    
    var body: some View {
        VStack() {
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    Color("bluegray")
                        .ignoresSafeArea(.all, edges: [.bottom, .trailing])
                    RoundedRectangle(cornerRadius: gui.cornerRadius25)
                        .fill(.white)
                        .frame(width: geo.size.width , height: geo.size.height * 0.70)
                        .overlay(
                            VStack() {
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
                                        Text("Ich hab noch nie...")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black)
                                        Spacer()
                                        Text(random[n])
                                            .fontWeight(.regular)
                                            .font(.title2)
                                            .padding(.horizontal)
                                            .foregroundColor(Color.black)
                                        Spacer()
                                    }
                                    .padding()
                                }
                                .padding([.leading, .bottom, .trailing])
                                .shadow(radius: 5, y: 4)
                                
                                Button(action: {
                                    if n == array.count - 1 {
                                        random = array.shuffled()
                                        withAnimation(.spring()) {
                                            n = 0
                                        }
                                    }
                                    else {
                                        withAnimation(.spring()) {
                                            n += 1
                                        }
                                    }
                                }) {
                                    Text(n == array.count - 1 ? "Neustart" : "Weiter")
                                        .fontWeight(.semibold)
                                        .font(.body)
                                }
                                .buttonStyle(ThreeD())
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                            }
                            .frame(height: geo.size.height * 0.64)
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
        .navigationBarTitle("Ich hab noch nie!")
    }
}


struct NochnieView_Previews: PreviewProvider {
    static var previews: some View {
        NochnieView()
    }
}
