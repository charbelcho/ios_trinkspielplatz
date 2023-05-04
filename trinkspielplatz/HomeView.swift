//
//  ContentView.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 21.12.21.
//

import SwiftUI

struct HomeView: View {
    var btnWidth:CGFloat
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(Color("teal"))
        btnWidth = 40.0
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Rectangle()
                   .fill(Color("bluegray"))
                   .frame(height: 10.0, alignment: .leading)

                ZStack(alignment: .top) {
                    Color("bluegray")
                        .ignoresSafeArea(.all, edges: [.bottom, .trailing])
                    ScrollView{
                    HStack{
                        Spacer()
                        GeometryReader { geo in
                            VStack(){
                                NavigationLink(destination: NochnieView()){
                                    Text("Ich hab noch nie!")
                                        .padding(.all)
                                        .background(Color("teal"))
                                }
                                .frame(width: geo.size.width, height: 100.0)
                                .cornerRadius(25.0)
                                .background(
                                    Color("teal")
                                    .cornerRadius(25.0)
                                )
                                
                                NavigationLink(destination: EherView()){
                                    Text("Wer würde eher?")
                                        .padding(.all)
                                        .background(Color("teal"))
                                }
                                .frame(width: geo.size.width, height: 100.0)
                                .cornerRadius(25.0)
                                .background(
                                    Color("teal")
                                    .cornerRadius(25.0)
                                )
                            }
                            Spacer()
                        }
                        
                        GeometryReader { geo in
                            VStack{
                                NavigationLink(destination: WahrheitPflichtView()){
                                    Text("Wahrheit oder Pflicht?")
                                        .padding(.all)
                                        .background(Color("teal"))
                                }
                                .frame(width: geo.size.width, height: 100.0)
                                .cornerRadius(25.0)
                                .background(
                                    Color("teal")
                                    .cornerRadius(25.0)
                                )
                                Spacer()
                            }
                            
                        }
                        Spacer()

                    }
                    }
                    .navigationTitle("Trinkspielplatz")
                    .navigationBarTitleDisplayMode(.inline)
                }
//            BannerAd(unitID: "ca-app-pub-5545282755961898/4498060356")
//                .frame(height: 100)
            }
            .background(Color("bluegray"))
            .navigationBarItems(trailing: NavigationLink(destination: AnleitungenView()) {
                Image(systemName: "info.circle")
                   .foregroundColor(.black)
            })
        }
        .navigationAppearance(backgroundColor: UIColor(Color("teal")), foregroundColor: UIColor(Color.black))
        .accentColor(Color.black)
        .background(Color("bluegray"))
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
