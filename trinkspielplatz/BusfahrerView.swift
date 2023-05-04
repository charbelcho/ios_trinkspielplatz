//
//  HoeherTiefer.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 08.01.22.
//

import SwiftUI
import SocketIO
import SimpleToast
import Combine

struct CardFront : View {
    let card: String
    let width: CGFloat
    let height: CGFloat
    @Binding var degree : Double

    var body: some View {
        ZStack {
            Image("png/\(card)")
                .resizable()
                .frame(width: width, height: height)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        .shadow(radius: 1)
    }
}


struct CardBack : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double

    var body: some View {
        ZStack {
            Image("png/back2")
                .resizable()
                .frame(width: width, height: height)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        .shadow(radius: 1)
    }
}


struct BusfahrerView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var service: ServiceBusfahrer = ServiceBusfahrer()

    let gui = Gui()
    @State var inactivityTimer = Timer.publish(every: 10, on: .current, in: .common).autoconnect()
    @State var connectedTimer: Cancellable? = nil
    @State private var showAnleitung = false
    var array: [Card] =  DataLoader().cardArray
    @State var random: [Card] = DataLoader().cardArray.shuffled()

    var setToast: (Int) -> Void
    
    @State var spielernameEingabe = ""
    @State var raumIdEingabe = ""
    @State var name = ""
    @State var raumModalText = ""
    
    @Binding var isLoading: Bool

    @State var alertTitleBusfahrer: String = ""
    @State var alertTextBusfahrer: String = ""
    @State var alertPlaceholderBusfahrer: String = ""
    @State var alertButtonTextBusfahrer: String = ""
    @State var correctInRow = 0

    @SceneStorage("connectedToSocket") var connectedToSocket: Bool = false
    @SceneStorage("busfahrerUsername") var busfahrerUsername = ""
    @SceneStorage("spielername") var spielername = ""
    @SceneStorage("busfahrer") var busfahrer = ""
    
    @State var roomBusfahrer = RoomBusfahrer(roomId: "", deck: [], users: [], phase: 1)
    @State var userBusfahrer = UserBusfahrer(id: "Hallo", username: "Du", eigeneKarten: [], flipArray: [false, false, false])
    
    @SceneStorage("roomBusfahrer") var roomBusfahrerStore: Data = Data()
    @SceneStorage("userBusfahrer") var userBusfahrerStore: Data = Data()

    @State var meineKarten: [Int] = [Int]()
    @State var fDegreeArray = [-90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0, -90.0]
    @State var bDegreeArray = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @State var flipArray = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    @State var myCardsFDegreeArray = [0.0, 0.0, 0.0]
    @State var myCardsBDegreeArray = [90.0, 90.0, 90.0]
    @State var myCardsFlipArray = [false, false, false]
    @State var trinkAnzahlArray = [0, 0 ,0]
    
    @SceneStorage("meineKarten") var meineKartenStore: Data = Data()
    @SceneStorage("fDegreeArray") var fDegreeArrayStore: Data = Data()
    @SceneStorage("bDegreeArray") var bDegreeArrayStore: Data = Data()
    @SceneStorage("flipArray") var flipArrayStore: Data = Data()
    @SceneStorage("myCardsFDegreeArray") var myCardsFDegreeArrayStore: Data = Data()
    @SceneStorage("myCardsBDegreeArray") var myCardsBDegreeArrayStore: Data = Data()
    @SceneStorage("myCardsFlipArray") var myCardsFlipArrayStore: Data = Data()
    @SceneStorage("trinkAnzahlArray") var trinkAnzahlArrayStore: Data = Data()
    
    let durationAndDelay : CGFloat = 0.1
    
    var body: some View {
        VStack(spacing: 0){
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
                            .disabled(service.roomBusfahrer.roomId
                                .count > 0 || service.busfahrerUsername.count == 0)
                            .buttonStyle(ThreeDLight())
                            .frame(width: geo.size.width * 0.3)

                            Spacer()
                            Button(action: {
                                if service.connectedToSocket {
                                    setAlertInfoBusfahrer(alert: 2)
                                }
                            }) {
                                Text("Raum\nbeitreten")
                                    .fontWeight(.semibold)
                                    .font(.caption)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                            }
                            .disabled(service.roomBusfahrer.roomId.count > 0 || service.busfahrerUsername.count == 0)
                            .buttonStyle(ThreeDLight())
                            .frame(width: geo.size.width * 0.3)

                            Spacer()
                            Button(action: {
                                raumVerlassen()
                            }) {
                                Text("Raum\nverlassen")
                                    .fontWeight(.semibold)
                                    .font(.caption)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                            }
                            .disabled(service.roomBusfahrer.roomId.count < 1)
                            .buttonStyle(ThreeDRed())
                            .frame(width: geo.size.width * 0.3)
                        }
                        .frame(width: geo.size.width * 0.95, height: 65)
                        .padding(.bottom, 5.0)

                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: gui.cornerRadius25)
                                .fill(.white)
                                .frame(width: geo.size.width * 0.95, height: service.openAlertBusfahrer /*&& service.roomBusfahrer.phase == 1*/ ? geo.size.height * 0.95 : geo.size.height * 0.75)
                                .overlay(
                                    VStack(){
                                        HStack(alignment: .top) {
                                            VStack(alignment: .leading){
                                                Text("Name:")
                                                Text("RaumID:")
                                                    .padding(.top, 3)
                                                Text("Ersteller:")
                                                    .padding(.top, 3)
                                            }
                                            .padding(.trailing)

                                            VStack(alignment: .leading){
                                                HStack{
                                                    Text(service.busfahrerUsername.count > 0 ? service.busfahrerUsername : "A")
                                                        .opacity(service.busfahrerUsername.count > 0 ? 1 : 0)
                                                    Spacer()
                                                    Button(action: {
                                                        setAlertInfoBusfahrer(alert: 1)
                                                        withAnimation(.spring()) {
                                                            service.openAlertBusfahrer = true
                                                        }
                                                    }) {
                                                        Text("Bearb.")
                                                            .foregroundStyle(Color(UIColor.systemBlue))
                                                    }
                                                    .opacity(service.busfahrerUsername.count > 0 && service.roomBusfahrer.roomId.count < 1 ? 1 : 0)
                                                    .buttonStyle(.plain)
                                                }
                                                Text(service.roomBusfahrer.roomId.count > 0 ? service.roomBusfahrer.roomId : "A")
                                                    .padding(.top, 3)
                                                    .opacity(service.roomBusfahrer.roomId.count > 0 ? 1 : 0)
                                                Text(service.roomBusfahrer.users.count > 0 ? service.roomBusfahrer.users[0].username : "A")
                                                    .padding(.top, 3)
                                                    .opacity(service.roomBusfahrer.users.count > 0 ? 1 : 0)
                                            }
                                            Spacer()
                                        }
                                        .padding(.horizontal)

                                        Divider()

                                        if service.roomBusfahrer.phase == 1 {
                                            ForEach(service.roomBusfahrer.users, id: \.id) { user in
                                                Text((user.username))
                                                    .padding(10.0)
                                                    .foregroundColor(Color.black)
                                            }
                                        }
                                        if service.roomBusfahrer.phase == 2 {
                                            BusfahrerPhase2View(service: service)
                                        }

                                        if service.roomBusfahrer.phase == 3 {
                                            BusfahrerPhase3View(service: service, correctInRow: $correctInRow, random: $random)
                                        }
                                        Spacer()
                                    }
                                    .frame(height: service.openAlertBusfahrer /*&& service.roomBusfahrer.phase == 1*/ ? geo.size.height * 0.9 : geo.size.height * 0.7)
                                )
                            Spacer()
                        }

                        HStack {
                            Button(action: {
                                if service.roomBusfahrer.phase == 1 {
                                    let data = arrayAsJson()
                                    service.isLoading = true
                                    service.austeilen(socketData: ["roomId": service.roomBusfahrer.roomId, "deck": data])
                                }
                                else if service.roomBusfahrer.phase == 2 {
                                    service.busfahren(socketData: ["roomId": service.roomBusfahrer.roomId])
                                }
                                else if service.roomBusfahrer.phase == 3 {
                                    service.roomBusfahrer.phase = 1
                                    service.resetGameInfo()
                                    resetGameInfo()
                                }
                            }) {
                                Text(service.roomBusfahrer.phase == 1 ? "Karten austeilen" : service.roomBusfahrer.phase == 2 ? "Busfahren" : "Zum Start")
                                    .fontWeight(.semibold)
                            }
                            .disabled(service.roomBusfahrer.phase == 3 && correctInRow < 5)
                            .buttonStyle(ThreeDLight())
                            .frame(width: geo.size.width * 0.95, height: geo.size.height * 0.08)
                        }
                        .frame(width: geo.size.width * 0.95)
                        .opacity(service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername ? 1.0 : 0.0)
                    }
                }
                .alert(alertTitleBusfahrer, isPresented: $service.openAlertBusfahrer, actions: {
                    if alertTitleBusfahrer == "Spielername" {
                        TextField("Spielername", text: $spielernameEingabe)
                            .onReceive(Just(spielernameEingabe)) { _ in limitText(&spielernameEingabe, 15) }
                            .disableAutocorrection(true)
                        Button(alertButtonTextBusfahrer, action: {
                            if service.roomBusfahrer.roomId.count == 0 {
                                service.isLoading = true
                                service.usernameBusfahrer(socketData: ["usernameBusfahrer" : spielernameEingabe])
                            }
                            else {
                                service.isLoading = true
                                service.usernameBusfahrer(socketData: ["roomId": service.roomBusfahrer.roomId, "usernameBusfahrerOld": service.busfahrerUsername, "usernameBusfahrerNew" : spielernameEingabe])
                            }
                            withAnimation(.spring()) {
                                service.openAlertBusfahrer = false
                            }
                        })
                    }
                    else if alertTitleBusfahrer == "Raum beitreten" {
                        TextField("RaumID", text: $raumIdEingabe)
                            .onReceive(Just(raumIdEingabe)) { _ in limitText(&raumIdEingabe, 15) }
                            .disableAutocorrection(true)
                        HStack {
                            Button("Abbr.", role: .destructive, action: {
                                withAnimation(.spring()) {
                                    service.openAlertBusfahrer = false
                                    service.isLoading = false
                                }
                            })
                            Button(alertButtonTextBusfahrer, role: .cancel, action: {
                                raumBeitretenBusfarer()
                                withAnimation(.spring()) {
                                    service.openAlertBusfahrer = false
                                }
                            })
                        }
                    }
                    else if alertTitleBusfahrer.contains("Busfahrer") {
                        Button(alertButtonTextBusfahrer, action: {
                            if service.roomBusfahrer.users[0].username == service.busfahrerUsername {
                                random = array.shuffled()
                                withAnimation(.spring()) {
                                    service.roomBusfahrer.phase = 3
                                    service.openAlertBusfahrer = false
                                }
                            }
                            else {
                                withAnimation(.spring()) {
                                    service.roomBusfahrer.phase = 1
                                    service.openAlertBusfahrer = false
                                }
                                service.resetGameInfo()
                            }
                        })
                    }
                    else {
                        HStack {
                            Button("Abbr."
                                   , role: .destructive, action: {service.openAlertBusfahrer = false})
                            Button(alertButtonTextBusfahrer, role: .cancel, action: {
                                withAnimation(.spring()) {
                                    service.openAlertBusfahrer = false
                                }
                                service.disconnectFromSocket()
                                service.resetGameInfo()
                                self.presentationMode.wrappedValue.dismiss()
                            })
                        }
                    }
                }, message: {
                    Text(alertTextBusfahrer)
                })
            }
            
            
            BannerAdView()
                .background(Color.black.opacity(0.2))
                .hidden(service.openAlertBusfahrer && service.roomBusfahrer.phase == 1)
        }
        .onAppear(perform: {
            if !service.connectedToSocket {
                isLoading = true
                service.connectToSocket()
            }
        })
        .onChange(of: service.connectedToSocket) { newValue in
            if newValue && service.busfahrerUsername.count == 0 {
                setAlertInfoBusfahrer(alert: 1)
            }
        }
        .onDisappear(perform: {
            if service.connectedToSocket {
                service.disconnectFromSocket()
            }
        })
        .onChange(of: service.busfahrer) { newValue in
            if newValue.count > 0 {
                setAlertInfoBusfahrer(alert: 3)
            }
        }
        .onChange(of: service.isLoading) { newValue in
            isLoading = newValue
        }
        .onChange(of: service.keinRaumGefundenBusfahrer) { newValue in
            if newValue {
                setToast(4)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    service.openAlertBusfahrer = true
                    service.keinRaumGefundenBusfahrer = false
                }
            }
        }
        .onChange(of: service.raumVollBusfahrer) { newValue in
            if newValue {
                setToast(5)
                service.raumVollBusfahrer = false
            }
        }
        .onChange(of: service.nameBesetztBusfahrer) { newValue in
            if newValue {
                setToast(6)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    setAlertInfoBusfahrer(alert: 1)
                    service.nameBesetztBusfahrer = false
                }
            }
        }
        .onReceive(inactivityTimer, perform: { _ in
            if scenePhase == .active {
                print("10 Sekunden vergangen")
                self.inactivityTimer.upstream.connect().cancel()
            } else {
                print("10 Sekunden vergangen im Hintergrund")
                if service.connectedToSocket {
                    service.disconnectFromSocket()
                    raumVerlassen()
                    self.inactivityTimer.upstream.connect().cancel()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        })
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive || newPhase == .background {
                print("Inactive or Backgound")
                self.inactivityTimer = Timer.publish(every: 10, on: .current, in: .common).autoconnect()
            } else if newPhase == .active {
                print("Active")
                if !service.connectedToSocket {
                    service.connectToSocket()
                    if service.busfahrerUsername.count == 0 {
                        setAlertInfoBusfahrer(alert: 1)
                    }
                }
                self.inactivityTimer.upstream.connect().cancel()
            }
        }
        .background(Color("bluegray"))
        .sheet(isPresented: $showAnleitung) {
            AnleitungenView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            setAlertInfoBusfahrer(alert: 4)
        }) {
            Image(systemName: "door.left.hand.open")
                .foregroundColor(.black)
        }, trailing: Button(action: {
                showAnleitung = true
        }) {
            Image(systemName: "info.circle")
               .foregroundColor(.black)
        })
        .navigationBarTitle("Busfahrer")
        
    }
        
    func raumErstellen() {
        if service.connectedToSocket {
            service.isLoading = true
            if service.roomBusfahrer.roomId == "" {
                service.createRoomBusfahrer(socketData: ["username": service.busfahrerUsername])
                setToast(1)
            }
        }
    }
    
    func raumBeitretenBusfarer() {
        if service.connectedToSocket {
            service.isLoading = true
            service.joinRoomBusfahrer(socketData: ["roomId": raumIdEingabe, "username": service.busfahrerUsername])
        }
    }
    
    func raumVerlassen() {
        isLoading = true
        if service.connectedToSocket {
            let user = service.roomBusfahrer.users.filter{ $0.username == service.busfahrerUsername }
            service.socketData = ["roomId": service.roomBusfahrer.roomId, "userId": user[0].id]
            withAnimation(.spring()) {
                service.roomBusfahrer = RoomBusfahrer(roomId: "", deck: [], users:[], phase: 0)
                service.resetGameInfo()
            }
            service.leaveRoomBusfahrer(socketData: service.socketData)
            setToast(3)
        }
        isLoading = false
    }
    
//    func encodeData() {
//        let encoder = JSONEncoder()
//        if let dataRoomBusfahrer = try? encoder.encode(service.roomBusfahrer) { roomBusfahrerStore = dataRoomBusfahrer }
//        if let dataUserBusfahrer = try? encoder.encode(service.userBusfahrer) { userBusfahrerStore = dataUserBusfahrer }
//        if let dataMeineKarten = try? encoder.encode(service.meineKarten) { meineKartenStore = dataMeineKarten }
//        if let dataFDegreeArray = try? encoder.encode(service.fDegreeArray) { fDegreeArrayStore = dataFDegreeArray }
//        if let dataBDegreeArray = try? encoder.encode(service.bDegreeArray) { bDegreeArrayStore = dataBDegreeArray }
//        if let dataFlipArray = try? encoder.encode(service.flipArray) { flipArrayStore = dataFlipArray }
//        if let dataMyCardsFDegreeArray = try? encoder.encode(service.myCardsFDegreeArray) { myCardsFDegreeArrayStore = dataMyCardsFDegreeArray }
//        if let dataMyCardsBDegreeArray = try? encoder.encode(service.myCardsBDegreeArray) { myCardsBDegreeArrayStore = dataMyCardsBDegreeArray }
//        if let dataMyCardsFlipArray = try? encoder.encode(service.myCardsFlipArray) { myCardsFlipArrayStore = dataMyCardsFlipArray }
//        if let dataTrinkAnzahlArray = try? encoder.encode(service.trinkAnzahlArray) { trinkAnzahlArrayStore = dataTrinkAnzahlArray }
//    }
//
//    func decodeData() {
//        let decoder = JSONDecoder()
//        if let dataRoomBusfahrer = try? decoder.decode(RoomBusfahrer.self, from: roomBusfahrerStore) { service.roomBusfahrer = dataRoomBusfahrer }
//        if let dataUserBusfahrer = try? decoder.decode(UserBusfahrer.self, from: userBusfahrerStore) { service.userBusfahrer = dataUserBusfahrer }
//        if let dataMeineKarten = try? decoder.decode([Int].self, from: meineKartenStore) { service.meineKarten = dataMeineKarten }
//        if let dataFDegreeArray = try? decoder.decode([Double].self, from: fDegreeArrayStore) { service.fDegreeArray = dataFDegreeArray }
//        if let dataBDegreeArray = try? decoder.decode([Double].self, from: bDegreeArrayStore) { service.bDegreeArray = dataBDegreeArray }
//        if let dataFlipArray = try? decoder.decode([Bool].self, from: flipArrayStore) { service.flipArray = dataFlipArray }
//        if let dataMyCardsFDegreeArray = try? decoder.decode([Double].self, from: myCardsFDegreeArrayStore) { service.myCardsFDegreeArray = dataMyCardsFDegreeArray }
//        if let dataMyCardsBDegreeArray = try? decoder.decode([Double].self, from: myCardsBDegreeArrayStore) { service.myCardsBDegreeArray = dataMyCardsBDegreeArray }
//        if let dataMyCardsFlipArray = try? decoder.decode([Bool].self, from: myCardsFlipArrayStore) { service.myCardsFlipArray = dataMyCardsFlipArray }
//        if let dataTrinkAnzahlArray = try? decoder.decode([Int].self, from: trinkAnzahlArrayStore) { service.trinkAnzahlArray = dataTrinkAnzahlArray }
//    }
    
    func arrayAsJson() -> String {
        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
        
        random = array.shuffled()
        let data = (try? encoder.encode(random))!
    
        let dataAsString = String(data: data, encoding: String.Encoding.utf8)
        return dataAsString!
    }
    
    func between(start: Int, value: Int, end: Int) -> Bool {
        if start < value && value < end {
            return true
        }
        else {
            return false
        }
    }
    
    func setAlertInfoBusfahrer(alert: Int) {
        if alert == 1 {
            alertTitleBusfahrer = "Spielername"
            alertTextBusfahrer = "Gib deinen Spielernamen ein."
            alertPlaceholderBusfahrer = "Spielername"
            alertButtonTextBusfahrer = "Speichern"
            withAnimation(.spring()) {
                service.openAlertBusfahrer = true
                service.isLoading = true
            }
        } else if alert == 2 {
            alertTitleBusfahrer = "Raum beitreten"
            alertTextBusfahrer = "Gib eine RaumID ein."
            alertPlaceholderBusfahrer = "RaumID"
            alertButtonTextBusfahrer = "Beitreten"
            withAnimation(.spring()) {
                service.openAlertBusfahrer = true
                service.isLoading = true
            }
        } else if alert == 3 {
            alertTitleBusfahrer = "\(service.busfahrer) ist Busfahrer!"
            alertTextBusfahrer = ""
            alertPlaceholderBusfahrer = ""
            if service.spielername == service.roomBusfahrer.users[0].username {
                alertButtonTextBusfahrer = "Busfahren"
            } else {
                alertButtonTextBusfahrer = "Zum Start"
            }
            withAnimation(.spring()) {
                service.openAlertBusfahrer = true
            }
        } else if alert == 4 {
            alertTitleBusfahrer = "Spiel verlassen?"
            alertTextBusfahrer = "Bist du sicher? Dein Spielstand wird nicht gespeichert"
            alertPlaceholderBusfahrer = ""
            alertButtonTextBusfahrer = "Verlassen"
            withAnimation(.spring()) {
                service.openAlertBusfahrer = true
            }
        }
    }
    
    func resetGameInfo(){
        withAnimation(.spring()) {
            correctInRow = 0
        }
    }
}

struct BusfahrerView_Previews: PreviewProvider {
    static var previews: some View {
        BusfahrerView(setToast: { _ in }, isLoading: .constant(false))
    }
}
