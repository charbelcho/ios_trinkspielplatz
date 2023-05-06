//
//  HoeherTiefer.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 08.01.22.
//

import SwiftUI
import SimpleToast
import Combine
import Foundation


struct WerBinIchView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var service: ServiceWerbinich
    let gui = Gui()
    @State private var showAnleitung = false
    @State private var spielernameEingabe = ""
    @State private var raumId = ""
    @State private var raumIdEingabe = ""
    @State private var werbinichText = ""
    @State private var raumModalText = ""
    @State private var alert: Int = 0
    @State private var alertTitle: String = ""
    @State private var alertText: String = ""
    @State private var alertPlaceholder: String = ""
    @State private var alertButtonText: String = ""
    @State private var showSafari: Bool = false

    var setToast: (Int) -> Void
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 5.0)
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    Color("bluegray")
                        .ignoresSafeArea(.all, edges: [.bottom, .trailing])

                    VStack {
                        HStack(spacing: 0) {
                            Button(action: {
                                raumErstellen()
                            }) {
                                Text("Raum\nerstellen")
                                    .fontWeight(.semibold)
                                    .font(.caption)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                            }
                            .disabled(service.room.roomId.count > 0)
                            .buttonStyle(ThreeDLight())
                            .frame(width: geo.size.width * 0.3)

                            Spacer()
                            Button(action: {
                                if service.connectedToSocket {
                                    withAnimation(.spring()) {
                                        setAlertInfo(alert: 2)
                                    }
                                }
                            }) {
                                Text("Raum\nbeitreten")
                                    .fontWeight(.semibold)
                                    .font(.caption)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                            }
                            .disabled(service.room.roomId.count > 0)
                            .buttonStyle(ThreeDLight())
                            .frame(width: geo.size.width * 0.3)

                            Spacer()
                            Button(action: {
                                raumVerlassen()
                            }) {
                                Text("Raum\nverlassen")
                                    .fontWeight(.semibold)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                                    .font(.caption)
                            }
                            .disabled(service.room.roomId.count < 1)
                            .buttonStyle(ThreeDRed())
                            .frame(width: geo.size.width * 0.3)

                        }
                        .frame(width: geo.size.width * 0.95, height: 65)

                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                .fill(.white)
                                .frame(width: geo.size.width * 0.95, height: service.openAlert ? geo.size.height * 0.9 : geo.size.height * 0.75)
                                .overlay(
                                    VStack{
                                        HStack{
                                            VStack(alignment: .leading){
                                                Text("Name:")
                                                Text("RaumID:")
                                                    .padding(.top, 3)
                                                Text("Ersteller:")
                                                    .padding(.top, 3)
                                            }
                                            .padding(.trailing)

                                            VStack(alignment: .leading){
                                                HStack {
                                                    Text(service.werbinichUsername.count > 0 ? service.werbinichUsername : "A")
                                                        .opacity(service.werbinichUsername.count > 0 ? 1 : 0)
                                                    Spacer()
                                                    Button(action: {
                                                        if service.room.roomId.count == 0 {
                                                            setAlertInfo(alert: 1)
                                                            withAnimation(.spring()) {
                                                                service.openAlert = true
                                                            }
                                                        }
                                                    }) {
                                                        Text("Bearb.")
                                                            .foregroundStyle(Color(UIColor.systemBlue))
                                                    }
                                                    .opacity(service.werbinichUsername.count == 0 || service.room.roomId.count > 0 ? 0 : 1)
                                                    .buttonStyle(.plain)
                                                }
                                                Text(service.room.roomId.count > 0 ? service.room.roomId : "A")
                                                    .padding(.top, 3)
                                                    .opacity(service.room.roomId.count > 0 ? 1 : 0)
                                                Text(service.room.users.count > 0 ? service.room.users[0].username : "A")
                                                    .padding(.top, 3)
                                                    .opacity(service.room.roomId.count > 0 ? 1 : 0)
                                            }
                                            Spacer()
                                        }
                                        .padding(.horizontal)

                                        Divider()

                                        ForEach(service.room.users, id: \.self) { user in
                                            if user.werbinich.text == "" {
                                                Text((user.username))
                                                    .padding()
                                                    .foregroundColor(Color.black)
                                            }
                                            else if user.username != service.werbinichUsername {
                                                HStack(spacing: 10) {
                                                    Text("\(user.username) : \(user.werbinich.text)")
                                                        .padding([.leading, .top, .bottom])
                                                        .foregroundColor(Color.black)
                                                        .sheet(isPresented: $showSafari, content: {
                                                            SFSafariViewWrapper(url: URL(string: user.werbinich.info)!)
                                                        })
                                                    
                                                    Button(action: {
                                                        showSafari.toggle()
                                                    }) {
                                                        Image(systemName: "info.circle")
                                                    }
                                                }
                                            }
                                            else {
                                                Text("\(user.username) : **********")
                                                    .padding()
                                                    .foregroundColor(Color.black)
                                            }
                                        }
                                        Spacer()
                                    }
                                    .frame(height: service.openAlert ? geo.size.height * 0.85 : geo.size.height * 0.7)
                                )
                            Spacer()
                        }
                        .padding(.top, 5.0)

                        HStack {
                            Button(action: {
                                service.auswaehlen(socketData: ["roomId": service.room.roomId])
                            }) {
                                Text("Auswählen")
                                    .fontWeight(.semibold)
                                    .font(.body)
                            }
                            .buttonStyle(ThreeDLight())
                            .frame(width: geo.size.width * 0.47, height: geo.size.height * 0.08)
                            

                            Button(action: {
                                service.isLoading = true
                                service.zuweisen(socketData: ["roomId": service.room.roomId])
                            }) {
                                Text("Zuweisen")
                                    .fontWeight(.semibold)
                                    .font(.body)
                            }
                            .buttonStyle(ThreeDLight())
                            .frame(width: geo.size.width * 0.47, height: geo.size.height * 0.08)
                        }
                        .frame(width: geo.size.width * 0.95)
                        .opacity(service.room.users[safe: 0]?.username == service.werbinichUsername ? 1.0 : 0.0)
                    }
                }
                .alert(alertTitle, isPresented: $service.openAlert, actions: {
                    if alertTitle == "Spielername" {
                        TextField("Spielername", text: $spielernameEingabe)
                            .onReceive(Just(spielernameEingabe)) { _ in limitText(&spielernameEingabe, 15) }
                            .disableAutocorrection(true)
                        Button(alertButtonText, action: {
                            if service.room.roomId.count == 0 {
                                if spielernameEingabe.count > 0 {
                                    service.isLoading = true
                                    service.usernameWerbinIch(socketData: spielernameEingabe)
                                    withAnimation(.spring()) {
                                        service.openAlert = false
                                    }
                                }
                            }
                        })
                    }
                    else if alertTitle == "Raum beitreten" {
                        TextField("RaumID", text: $raumIdEingabe)
                            .onReceive(Just(raumIdEingabe)) { _ in limitText(&raumIdEingabe, 15) }
                            .disableAutocorrection(true)
                        HStack {
                            Button("Abbr.", role: .destructive, action: {
                                withAnimation(.spring()) {
                                    service.openAlert = false
                                    service.isLoading = false
                                }
                            })
                            Button(alertButtonText, role: .cancel, action: {
                                raumBeitreten()
                            })
                        }
                    } else if alertTitle.contains("Wähle Namen für") {
                        TextField("Wer ist \(service.speichernFuerUsername)", text: $werbinichText)
                            .onReceive(Just(werbinichText)) { _ in limitText(&werbinichText, 25) }
                            .disableAutocorrection(true)
                        Button(alertButtonText, action: {
                            service.isLoading = true
                            service.namenSpeichern(socketData: ["roomId": service.room.roomId, "username": service.speichernFuerUsername, "werbinich": werbinichText])
                            withAnimation(.spring()) {
                                service.openAlert = false
                            }
                        })
                    }
                }, message: {
                    Text(alertText)
                })
            }
            
            BannerAdView()
                .hidden(service.openAlert)
        }
        .onAppear(perform: {
            if service.connectedToSocket {
                service.isLoading = true
                setAlertInfo(alert: 1)
            }
        })
        .onChange(of: service.isLoading) { newValue in
            isLoading = newValue
        }
        .onChange(of: service.keinRaumGefunden) { newValue in
            if newValue {
                setToast(4)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    service.openAlert = true
                    service.keinRaumGefunden = false
                }
            }
        }
        .onChange(of: service.raumVoll) { newValue in
            if newValue {
                setToast(5)
                service.raumVoll = false
            }
        }
        .onChange(of: service.nameBesetzt) { newValue in
            if newValue {
                setToast(6)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    setAlertInfo(alert: 1)
                    service.nameBesetzt = false
                }
            }
        }
        .onChange(of: service.ausgewaehlt) { newValue in
            if newValue {
                setAlertInfo(alert: 3)
                service.ausgewaehlt = false
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if !service.connectedToSocket {
                    service.connectToSocket()
                }
            }
        }
        .background(Color("bluegray"))
        .sheet(isPresented: $showAnleitung) {
            AnleitungenView()
        }
        .navigationBarItems(trailing: NavigationLink(destination: AnleitungenView()) {
            Image(systemName: "info.circle")
                .foregroundColor(.black)
        })
        .navigationBarTitle("Wer bin ich?")
        
    }
    
    func raumErstellen() {
        if service.connectedToSocket {
            service.isLoading = true
            if service.room.roomId == "" {
                service.createRoom(socketData: ["username": service.werbinichUsername])
                setToast(1)
            }
        }
    }
    
    func raumBeitreten() {
        if service.connectedToSocket {
            service.isLoading = true
            service.joinRoom(socketData: ["roomId": raumIdEingabe, "username": service.werbinichUsername])
        }
    }
    
    func raumVerlassen() {
        let user = service.room.users.filter{ $0.username == service.werbinichUsername }
        service.socketData = ["roomId": service.room.roomId, "userId": user[0].id]
        withAnimation(.spring()) {
            service.room = Room(roomId: "", users:[])
        }
        service.raumIdWerbinich = ""
        service.leaveRoom(socketData: service.socketData)
        setToast(3)
    }
    
    func setAlertInfo(alert: Int) {
        if alert == 1 {
            alertTitle = "Spielername"
            alertText = "Gib deinen Spielernamen ein."
            alertPlaceholder = "Spielername"
            alertButtonText = "Speichern"
            withAnimation(.spring()) {
                service.openAlert = true
                service.isLoading = true
            }
        } else if alert == 2 {
            alertTitle = "Raum beitreten"
            alertText = "Gib eine RaumID ein."
            alertPlaceholder = "RaumID"
            alertButtonText = "Beitreten"
            withAnimation(.spring()) {
                service.openAlert = true
                service.isLoading = true
            }
        } else if alert == 3 {
            alertTitle = "Wähle Namen für \(service.speichernFuerUsername)"
            alertText = ""
            alertPlaceholder = ""
            alertButtonText = "Speichern"
            withAnimation(.spring()) {
                service.openAlert = true
                service.isLoading = true
            }
        }
    }
}

struct WerBinIchView_Previews: PreviewProvider {
    static var previews: some View {
        WerBinIchView(service: ServiceWerbinich(), setToast: { _ in }, isLoading: .constant(false))
    }
}


