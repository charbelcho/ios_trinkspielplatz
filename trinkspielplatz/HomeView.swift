//
//  ContentView.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 21.12.21.
//

import SwiftUI
import CoreData
import SimpleToast
import Combine


struct HomeView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @State var inactivityTimer = Timer.publish(every: 60 * 60, on: .current, in: .common).autoconnect()
    
    let gui = Gui()
    @State private var showAnleitung = false
    
    @StateObject var serviceWerbinich = ServiceWerbinich()

    @State var isLoading: Bool = false
    @State var raumIdEingabeWerbinich: String = ""
    
    @State var showToast: Bool = false
    @State var toastNumber: Int = 0
    @State var toastIcon: String = ""
    @State var toastText: String = ""
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(Color("teal"))
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        
    }

    var body: some View {
        NavigationView{
            VStack{
                Spacer(minLength: 10.0)
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
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)

                                    NavigationLink(destination: EherView()){
                                        Text("Wer würde eher?")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)

                                    NavigationLink(destination: BangView()){
                                        Text("BANG!")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)

                                    NavigationLink(destination: PferderennenView()){
                                        Text("Pferderennen")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)
                                    
                                    NavigationLink(destination: WerBinIchView(service: serviceWerbinich, setToast: setToast, isLoading: $isLoading)){
                                        Text("Wer bin ich?")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)
                                    
                                    NavigationLink(destination: MaexchenView()){
                                        Text("Mäxchen")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)
                                    
                                    NavigationLink(destination: WuerfelView()){
                                        Text("Würfel")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)

                                }
                                Spacer()
                            }

                            GeometryReader { geo in
                                VStack{
                                    NavigationLink(destination: WahrheitPflichtView()){
                                        Text("Wahrheit oder\nPflicht?")
//                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)

                                    NavigationLink(destination: HoeherTieferView()){
                                        Text("Höher oder\nTiefer?")
//                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)

                                    NavigationLink(destination: ShitheadView()){
                                        Text("Captain Shithead")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)

                                    NavigationLink(destination: KingsCupView()){
                                        Text("King's Cup")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)

                                    NavigationLink(destination: BusfahrerView(setToast: setToast, isLoading: $isLoading)) {
                                        Text("Busfahrer")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)
                                    
                                    NavigationLink(destination: EinhundertView()){
                                        Text("100")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)
                                    
                                    NavigationLink(destination: KartenView()){
                                        Text("Karten")
                                            .padding(.all)
                                    }
                                    .padding(.bottom, 5.0)
                                    .buttonStyle(ThreeDLight())
                                    .frame(width: geo.size.width, height: gui.navLinkHeight)
                                    
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        .sheet(isPresented: $showAnleitung) {
                            AnleitungenView()
                        }
                    }
                    .navigationTitle("Trinkspielplatz")
//                    .navigationBar.titleTextAttributes[]
                    .navigationBarTitleDisplayMode(.inline)
//                    .navigationAppearance(backgroundColor: .clear, tintColor: .white)
                }
//                BannerAdView()
            }
            .background(Color("bluegray"))
            .navigationBarItems(trailing:
                Button(action: {
                    showAnleitung = true
                }) {
                    Image(systemName: "info.circle")
                       .foregroundColor(.black)
            })
        }
        .background(Color("teal"))
        .foregroundColor(Color.black)
        .accentColor(Color.black)
        .background(Color("bluegray"))
        .overlay(
            GeometryReader { geo in
                ZStack {
                    ZStack {}
                        .simpleToast(isPresented: $showToast, options: SimpleToastOptions(alignment: .center, hideAfter: 2, animation: .spring(), modifierType: .scale)) {
                            HStack {
                                Image(systemName: toastIcon)
                                Text(toastText)
                            }
                            .padding()
                            .background(toastNumber < 3 ? Color.green : Color.red)
                            .foregroundColor(Color.white)
                            .cornerRadius(gui.cornerRadius25)
                        }
                }
                .background(Color.black.opacity(0.1))
                .opacity(showToast ? 1 : 0)

                ZStack{
                   VStack {
                       ProgressView()
                           .progressViewStyle(CircularProgressViewStyle())
                           .scaleEffect(2.0, anchor: .center)
                           .padding(.all
                           )
                       Text("Loading...")
                          .foregroundColor(.black)
                   }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.1))
                .opacity(isLoading ? 1 : 0)
            }
        )
        .onReceive(inactivityTimer, perform: { _ in
            if scenePhase == .active {
                self.inactivityTimer.upstream.connect().cancel()
            } else {
                if serviceWerbinich.connectedToSocket {
                    serviceWerbinich.disconnectFromSocket()
                    raumVerlassenWerbinich()
                }
                self.inactivityTimer.upstream.connect().cancel()
            }
        })
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive || newPhase == .background {
                inactivityTimer = Timer.publish(every: 60 * 60, on: .current, in: .common).autoconnect()
            } else if newPhase == .active {
                self.inactivityTimer.upstream.connect().cancel()
                if !serviceWerbinich.connectedToSocket {
                    serviceWerbinich.connectToSocket()
                }
            }
        }
    }
    
    func setToast(nr: Int) -> Void {
        toastNumber = nr
        if nr < 3 {
            toastIcon = "checkmark.circle"
        }
        else {
            toastIcon = "x.circle"
        }
        switch nr {
        case 1:
            toastText = "Raum erstellt"
        case 2:
            toastText = "Raum beigetreten"
        case 3:
            toastText = "Raum verlassen"
        case 4:
            toastText = "Kein Raum gefunden"
        case 5:
            toastText = "Raum voll"
        case 6:
            toastText = "Name besetzt"
        default: break
        }
        showToast.toggle()
    }
    
    func raumVerlassenWerbinich() {
        if serviceWerbinich.connectedToSocket {
            isLoading = true
            let users = serviceWerbinich.room.users.filter{ $0.username != serviceWerbinich.werbinichUsername }
            serviceWerbinich.socketData = ["roomId": serviceWerbinich.room.roomId, "users": users]
            withAnimation(.spring()) {
                serviceWerbinich.room = Room(roomId: "", users:[])
            }
            serviceWerbinich.raumIdWerbinich = ""
            serviceWerbinich.leaveRoom(socketData: serviceWerbinich.socketData)
            setToast(nr: 3)
            isLoading = false
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


