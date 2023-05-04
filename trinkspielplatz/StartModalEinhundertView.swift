//
//  BangView.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 16.06.22.
//

import SwiftUI
import Combine

struct StartModalEinhundertView: View {
    @Binding var isStartModalOpen: Bool
    @ObservedObject var spieler = Spieler100(name: "", punkte: 0)
    let gui = Gui()
    @State var name: String = ""
    @State var missing = false
    @State var alertTitle: String = ""
    @State var alertText: String = ""
    @State var spielerBearbeiten: Bool = false
    @FocusState private var focused: Bool

    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    GeometryReader { geo in
                        Color("bluegray")
                            .ignoresSafeArea(.all, edges: [.bottom, .trailing])
                        VStack {
                            RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                .fill(.white)
                                .frame(width: geo.size.width , height: geo.size.height * 0.65)
                                .overlay(
                                    ScrollView(.vertical) {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("Spieler")
                                                    .font(.system(size: 45, weight: .bold, design: .default))
                                                    .padding(.horizontal)
                                                
                                                Spacer()
                                                
                                                Button(action: {
                                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                                                    to:nil, from:nil, for:nil)
                                                    spielerBearbeiten.toggle()
                                                }) {
                                                    Text(spielerBearbeiten ? "Speichern" : "Bearb.")
                                                        .foregroundStyle(Color.accentColor)
                                                }
                                                .opacity(spieler.items.count > 0 ? 1 : 0)
                                                .buttonStyle(.plain)
                                                .padding(.horizontal)
                                            }
                                            .padding(.bottom)
                                            
                                            ForEach($spieler.items){ $item in
                                                HStack{
                                                    if spielerBearbeiten == false {
                                                        Text(item.name)
                                                    }
                                                    else {
                                                        VStack {
                                                            HStack {
                                                                TextField("Name",text: $item.name)
                                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                                    .onReceive(Just(item.name)) { _ in limitText(&item.name, 15) }
                                                                    .disableAutocorrection(true)
                                                                
                                                                Button(action: {
                                                                    deleteSpieler(id: $item.id)
                                                                }) {
                                                                    Image(systemName: "trash")
                                                                        .foregroundColor(.white)
                                                                        .frame(width: 50.0, height: 32)
                                                                        .background(Color.red)
                                                                        .overlay(
                                                                            RoundedRectangle(cornerRadius: 5)
                                                                                .stroke(Color("bluegray"), lineWidth: 1)
                                                                        )
                                                                }
                                                                .cornerRadius(5.0)
                                                            }
                                                        }
                                                    }
                                                }
                                                .padding(.horizontal)
                                                
                                                Divider()
                                            }
                                        }
                                    }
                                    .frame(height: geo.size.height * 0.64)
                                )
                            
                            RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                .fill(.white)
                                .frame(width: geo.size.width , height: 145)
                                .overlay(
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Name")
                                                .padding([.top, .leading])
                                                .frame(width: geo.size.width * 0.25)
                                            TextField("Name", text: $name)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .padding([.top, .leading, .trailing])
                                                .onReceive(Just(name)) { _ in limitText(&name, 15) }
                                                .focused($focused)
                                                .onAppear(perform: {focused = true})
                                                .disableAutocorrection(true)
                                        }
                                        Divider()
                                        
                                        HStack {
                                            Button(action: {
                                                if name.count < 1 {
                                                    missing = true
                                                    alertTitle = "Fehlender Name"
                                                    alertText = "Gib einen Namen für den Spieler ein"
                                                }
                                                else {
                                                    spieler.items.append(Spieler100(name: name, punkte: 0))
                                                    name = ""
                                                    alertTitle = ""
                                                    alertText = ""
                                                }
                                            })
                                            {
                                            Text("Hinzufügen")
                                                .fontWeight(.semibold)
                                                .font(.body)
                                            }
                                            .buttonStyle(ThreeDLight())
                                            .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.07)
                                            .padding(.horizontal)
                                            .alert(isPresented: $missing){
                                                Alert(title: Text(alertTitle), message: Text(alertText), dismissButton: .default(Text("Ok!")))
                                            }
                                            
                                            Spacer()
                                            Button(action: {
                                                if spieler.items.count < 2 {
                                                    missing = true
                                                    alertTitle = "Fehlende Spieler"
                                                    alertText = "Füge mindestens 2 Spieler hinzu, um das Spiel zu starten!"
                                                }
                                                else {
                                                    isStartModalOpen = false
                                                }
                                            })
                                            {
                                                Image(systemName: "play.fill")
                                                    .fontWeight(.semibold)
                                                    .font(.body)
                                            }
                                            .buttonStyle(ThreeDLight())
                                            .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.07)
                                            .padding(.horizontal)
                                        }
                                    }
                                    .frame(height: geo.size.height * 0.15)
                                )
                        }
                    }
                }
                .padding(.horizontal,10)
                .background(Color("bluegray"))
            }
        }
    }
    
    func deleteSpieler(id: UUID) {
        let filteredSpieler = spieler.items.filter{$0.id != id}
        spieler.items = filteredSpieler
    }
}


struct StartModalEinhundertView_Previews: PreviewProvider {
    static var previews: some View {
        StartModalEinhundertView(isStartModalOpen: .constant(false))
    }
}
