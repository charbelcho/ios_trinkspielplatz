//
//  BangView.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 16.06.22.
//

import SwiftUI

struct BangView: View {
    init() {}
    let gui = Gui()
    @State private var showAnleitung = false
    @State var timerRunning = false
    @State var test = false
    @State var seconds = 4
    @State private var hasTimeElapsed = false
    @State var bangText = ""
    @State var randomDouble = UInt64(0)
    @State var spielerZuFrueh = 0
    @State var verlierer = 0
    @State var randomZuFruehTrinkzahl = 0
    @State var randomVerliererTrinkzahl = 0
    @State var isZuFruehModalOpen: Bool = false
    @State var isVerliererModalOpen: Bool = false
    @State var buttonVisible: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var bangTask = Task{}
    @State var timeSpieler1 = 0.0
    @State var timeSpieler2 = 0.0
    
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    Color("bluegray")
                        .ignoresSafeArea(.all, edges: [.bottom, .trailing])
                    RoundedRectangle(cornerRadius: gui.cornerRadius25)
                        .fill(.white)
                        .frame(width: geo.size.width, height: geo.size.height * 0.95)
                        .overlay(
                            VStack() {
                                Button(action: {
                                    if hasTimeElapsed == false && timerRunning {
                                        toFast(spieler: 1)
                                    }
                                    else if hasTimeElapsed == false && timerRunning == false {
                                        delayBang()
                                    }
                                    else if hasTimeElapsed && timerRunning == false {
                                        if timeSpieler1 == 0.0 {
                                            timeSpieler1 = CFAbsoluteTimeGetCurrent()
                                        }
                                        compareTime()
                                    }
                                    else if hasTimeElapsed && timerRunning {
                                        delayBang()
                                    }
                                }) {
                                    Text((hasTimeElapsed && timerRunning) || (hasTimeElapsed == false && timerRunning == false) ? "Start" : "BANG!")
                                        .fontWeight(.semibold)
                                        .font(.body)
                                        .rotationEffect(.degrees(180))
                                }
                                .buttonStyle(ThreeD180())
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                                .fullScreenCover(isPresented: $isZuFruehModalOpen) {
                                    ZuFruehModalBangView(isZuFruehModalOpen: $isZuFruehModalOpen, spielerZuFrueh: $spielerZuFrueh, randomZuFruehTrinkzahl: $randomZuFruehTrinkzahl, buttonVisible: $buttonVisible).onAppear(perform: {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            buttonVisible = true
                                        }
                                    })
                                }
                                .fullScreenCover(isPresented: $isVerliererModalOpen) {
                                    VerliererModalBangView(isVerliererModalOpen: $isVerliererModalOpen, verlierer: $verlierer, randomVerliererTrinkzahl: $randomVerliererTrinkzahl, buttonVisible: $buttonVisible).onAppear(perform: {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            buttonVisible = true
                                        }
                                    })
                                }
                                Text("Spieler 1")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .rotationEffect(.degrees(180))
                                
                                Spacer()
                                Text(seconds != 4 ? (hasTimeElapsed ? "BANG!" : "\(seconds)") : "Start")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .font(.largeTitle)
                                    .rotationEffect(.degrees(180))
                                    .onReceive(timer) { time in
                                        if timerRunning == true {
                                            if seconds > 1 {
                                                seconds -= 1
                                            }
                                        }
                                    }
                                Divider()
                                Text(seconds != 4 ? (hasTimeElapsed ? "BANG!" : "\(seconds)") : "Start")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .font(.largeTitle)
                                Spacer()
                                Text("Spieler 2")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                
                                Button(action: {
                                    if hasTimeElapsed == false && timerRunning {
                                        toFast(spieler: 2)
                                    }
                                    else if hasTimeElapsed == false && timerRunning == false {
                                        delayBang()
                                    }
                                    else if hasTimeElapsed && timerRunning == false {
                                        if timeSpieler2 == 0.0 {
                                            timeSpieler2 = CFAbsoluteTimeGetCurrent()
                                        }
                                        compareTime()
                                    }
                                    else if hasTimeElapsed && timerRunning {
                                        delayBang()
                                    }
                                }) {
                                    Text((hasTimeElapsed && timerRunning) || (hasTimeElapsed == false && timerRunning == false) ? "Start" : "BANG!")
                                        .fontWeight(.semibold)
                                        .font(.body)
                                }
                                .buttonStyle(ThreeD())
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                            }
                            .frame(height: geo.size.height * 0.88)
                        )
                }
            }
            .padding(.all, 10.0)
            
            Spacer()
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
        .navigationBarTitle("BANG!")
    }
    
    func delayBang() {
        hasTimeElapsed = false
        timerRunning = true
        randomDouble = UInt64((Double.random(in: 4...11) * 1000000000))
        bangTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(5000000000))
            hasTimeElapsed = true
            timerRunning = false
        }
        seconds = 4
    }
    
    func toFast(spieler: Int) {
        if hasTimeElapsed { return }
        bangTask.cancel()
        Task {
           await set()
        }
        isZuFruehModalOpen = true
        spielerZuFrueh = spieler
        randomZuFruehTrinkzahl = Int.random(in: 1...7)
        seconds = 4
    }
    func set() async{
        hasTimeElapsed = false
        timerRunning = false
    }
    
    func win(spieler: Int) {
        isVerliererModalOpen = true
        verlierer = spieler
        randomVerliererTrinkzahl = Int.random(in: 1...7)
        timerRunning = true
        timeSpieler1 = 0.0
        timeSpieler2 = 0.0
    }
    
    func compareTime() {
        if timeSpieler1 > timeSpieler2 && timeSpieler2 > 0.0 {
            verlierer = 1
        }
        else if timeSpieler2 > 0.0 && timeSpieler1 == 0.0 {
            verlierer = 1
        }
        else if timeSpieler2 > timeSpieler1 && timeSpieler1 > 0.0 {
            verlierer = 2
        }
        else if timeSpieler1 > 0.0 && timeSpieler2 == 0.0 {
            verlierer = 2
        }
        win(spieler: verlierer)
    }
}


struct BangView_Previews: PreviewProvider {
    static var previews: some View {
        BangView()
    }
}
