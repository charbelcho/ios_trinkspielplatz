//
//  SwiftUIView.swift
//  test_app
//
//  Created by Charbel Chougourou on 20.12.21.
//

import SwiftUI

struct WahrheitPflichtView: View {
    let gui = Gui()
    @State private var showAnleitung = false
    var array = DataLoader().wahrheitArray
    var array2 = DataLoader().pflichtArray
    @State var random = DataLoader().wahrheitArray.randomElement()
    @State var random2 = DataLoader().pflichtArray.randomElement()
    @State var visibleWahrheit = false
    @State var visiblePflicht = false
    @State var visibleTrinkanzahl = false
    @State var trinkanzahl = 0
    @State var n = 0
    @State var m = 0
    
    
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    Color("bluegray")
                        .ignoresSafeArea(.all, edges: [.bottom, .trailing])
                    RoundedRectangle(cornerRadius: gui.cornerRadius25)
                        .fill(.white)
                        .frame(width: geo.size.width, height: geo.size.height * 0.75)
                        .overlay(
                            VStack() {
                                if visibleWahrheit == false && visibleTrinkanzahl == false {
                                    Button(action: {
                                        if visibleWahrheit == false && visiblePflicht == false {
                                            withAnimation(.spring()) {
                                                visibleWahrheit = true
                                            }
                                        }
                                    }) {
                                        Text("Wahrheit")
                                            .fontWeight(.regular)
                                            .font(.title)
                                            .foregroundColor(Color.white)
                                    }
                                    .buttonStyle(ThreeDBlueGray())
                                    .frame(height: geo.size.height * 0.25)
                                    
                                }
                                else if visiblePflicht == false && visibleTrinkanzahl == true {
                                    Spacer()
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                            .frame(height: geo.size.height * 0.55)
                                            .foregroundColor(Color("bluegray"))
                                            .offset(y: 5)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                                    .offset(y: 5)
                                            )
                                        
                                        RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                            .frame(height: geo.size.height * 0.55)
                                            .foregroundColor(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                            )
                                        
                                        Text("Trinke \(trinkanzahl) Schlucke!")
                                            .fontWeight(.regular)
                                            .frame(height: geo.size.height * 0.55)
                                            .font(.title)
                                            .padding(.horizontal)
                                            .foregroundColor(Color.black)
                                    }
                                    .shadow(radius: 5, y: 4)
                                    
                                    Spacer()
                                }
                                else if visibleWahrheit == true {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                            .frame(height: geo.size.height * 0.25)
                                            .foregroundColor(Color("bluegray"))
                                            .offset(y: 5)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                                    .offset(y: 5)
                                            )
                                        
                                        RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                            .frame(height: geo.size.height * 0.25)
                                            .foregroundColor(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                            )
                                        
                                        Text(random ?? "")
                                            .fontWeight(.regular)
                                            .frame(height: geo.size.height * 0.25)
                                            .font(.headline)
                                            .padding(.horizontal)
                                            .foregroundColor(Color.black)
                                    }
                                    .shadow(radius: 5, y: 4)
                                }

                                Spacer()
                                if visiblePflicht == false && visibleTrinkanzahl == false {
                                    Button(action: {
                                        if visibleWahrheit == false && visiblePflicht == false {
                                            withAnimation(.spring()) {
                                                visiblePflicht = true
                                            }
                                        }
                                    }) {
                                        Text("Pflicht")
                                            .fontWeight(.regular)
                                            .font(.title)
                                    }
                                    .buttonStyle(ThreeDBlueGray())
                                    .frame(height: geo.size.height * 0.25)

                                }
                                else if visibleWahrheit == false && visibleTrinkanzahl == true {
                                    Spacer()
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                            .frame(height: geo.size.height * 0.55)
                                            .foregroundColor(Color("bluegray"))
                                            .offset(y: 5)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                                    .offset(y: 5)
                                            )
                                        
                                        RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                            .frame(height: geo.size.height * 0.55)
                                            .foregroundColor(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                            )
                                        
                                        Text("Trinke \(trinkanzahl) Schlucke!")
                                            .fontWeight(.regular)
                                            .frame(height: geo.size.height * 0.55)
                                            .font(.title)
                                            .padding(.horizontal)
                                            .foregroundColor(Color.black)
                                    }
                                    .shadow(radius: 5, y: 4)
                                    
                                    Spacer()
                                }
                                else if visiblePflicht == true {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                            .frame(height: geo.size.height * 0.25)
                                            .foregroundColor(Color("bluegray"))
                                            .offset(y: 5)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                                    .offset(y: 5)
                                            )
                                        
                                        RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                            .frame(height: geo.size.height * 0.25)
                                            .foregroundColor(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("bluegray"), lineWidth: 1)
                                            )
                                        
                                        Text(random2 ?? "")
                                            .fontWeight(.regular)
                                            .frame(height: geo.size.height * 0.25)
                                            .font(.headline)
                                            .padding(.horizontal)
                                            .foregroundColor(Color.black)
                                    }
                                    .shadow(radius: 5, y: 4)
                                }
                                Spacer()
                                
                                HStack() {
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            random = DataLoader().wahrheitArray.randomElement()
                                            random2 = DataLoader().pflichtArray.randomElement()
                                            visibleWahrheit = false
                                            visiblePflicht = false
                                            visibleTrinkanzahl = false
                                        }
                                        trinkanzahl = 0
                                    }) {
                                        Text("Weiter")
                                            .fontWeight(.semibold)
                                            .font(.body)
                                    }
                                    .disabled(!visibleWahrheit && !visiblePflicht)
                                    .buttonStyle(ThreeD())
                                    .frame(width: geo.size.width * 0.65, height: geo.size.height * 0.08)

                                    Spacer()
                                    Button(action: {
                                        if visibleTrinkanzahl == false {
                                            withAnimation(.spring()) {
                                                visibleTrinkanzahl = true
                                            }
                                            trinkanzahl = Int.random(in: 3...7)
                                        }
                                    }) {
                                        Image("biericon")
                                            .resizable()
                                            .frame(width: geo.size.width * 0.08, height: geo.size.width * 0.08)
                                            .padding(.all, 5.0)
                                    }
                                    .disabled(!visibleWahrheit && !visiblePflicht)
                                    .buttonStyle(ThreeD())
                                    .frame(width: geo.size.width * 0.08, height: geo.size.width * 0.08)
                                    
                                }
                                .padding(.trailing, 8.0)
                            }
                            .frame(height: geo.size.height * 0.7)
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
        .navigationBarItems(trailing: Button(action: {
            showAnleitung = true
        }) {
            Image(systemName: "info.circle")
               .foregroundColor(.black)
        })
        .navigationBarTitle("Wahrheit oder Pflicht?")
    }
}
struct WahrheitPflichtView_Previews: PreviewProvider {
    static var previews: some View {
       WahrheitPflichtView()
    }
}

