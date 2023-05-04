//
//  HoeherTiefer.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 08.01.22.
//

import SwiftUI


struct MaexchenView: View {
    let gui = Gui()
    @State private var showAnleitung = false
    @State var visibleTrinkzahl: Bool = false
    @State var randomTrinkzahl: Int = 0
    @State var choose: Bool = false
    @State var gewuerfelt: Bool = false
    @State var delayEnable: Bool = true
    
    @State private var rolling: Bool = false
    @State private var value: Int = 1
    @State private var value2: Int = 1
    @State private var valueHidden: Int = 0
    @State private var value2Hidden: Int = 0
    @State private var scale: CGFloat = 1
    @State private var angle: Double = 0
    
    @State private var offset: CGFloat = -5
    @State private var isBouncing = false
    
    //MARK
    @State private var showTippen = true
    
    var body: some View {
        VStack{
            ZStack{
                GeometryReader { geo in
                    Color("bluegray")
                        .ignoresSafeArea(.all, edges: [.bottom, .trailing])
                    RoundedRectangle(cornerRadius: gui.cornerRadius25)
                        .fill(.white)
                        .frame(width: geo.size.width , height: geo.size.height)
                        .overlay(
                            ZStack {
                                ZStack{
                                    VStack(spacing: 0){
                                        Text("Tippe zum Würfeln")
                                            .padding()
                                            .opacity(showTippen ? 1 : 0)
                                        
                                        Image(systemName: "arrow.down")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .offset(y: offset)
                                            .opacity(showTippen ? 1 : 0)
                                            .onAppear {
                                                withAnimation(.easeInOut.repeatForever(autoreverses: true)){
                                                    offset += 5
                                                }
                                            }
                                        
                                        Spacer()
                                    }
                                }
                                .hidden(rolling || choose || gewuerfelt || visibleTrinkzahl)
                                
                                VStack() {
                                    HStack {
                                        Button(action: {
                                            if visibleTrinkzahl == false {
                                                withAnimation(.spring()) {
                                                    visibleTrinkzahl = true
                                                    randomTrinkzahl = Int.random(in: 3...7)
                                                }
                                            }
                                        }) {
                                            Image("biericon")
                                                .resizable()
                                                .frame(width: geo.size.width * 0.08, height: geo.size.width * 0.08)
                                                .padding(.all, 5.0)
                                        }
                                        .buttonStyle(ThreeD())
                                        .frame(width: geo.size.width * 0.08, height: geo.size.width * 0.08)
                                        
                                        Spacer()
                                    }
                                    .padding(10)
                                    
                                    Spacer(minLength: 5.0)
                                    Image("wuerfel-\(value)-black")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: geo.size.width * 0.4)
                                        .rotationEffect(.degrees(angle))
                                        .scaleEffect(scale)
                                        .shadow(radius: 10)
                                        .onTapGesture {
                                            wuerfeln()
                                        }
                                    
                                    Spacer()
                                    Image("wuerfel-\(value2)-black")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: geo.size.width * 0.4)
                                        .rotationEffect(.degrees(angle))
                                        .scaleEffect(scale)
                                        .shadow(radius: 10)
                                        .onTapGesture {
                                            wuerfeln()
                                        }
                                    
                                    Spacer()
                                    
                                    if !choose {
                                        Button(action: {
                                            offset = -5
                                            showTippen = false
                                            valueHidden = value
                                            value2Hidden = value2
                                            withAnimation(.spring()) {
                                                value = 0
                                                value2 = 0
                                                choose = true
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                withAnimation(.spring()) {
                                                    delayEnable = false
                                                }
                                            }
                                        }) {
                                            Text("Nächster Spieler")
                                                .fontWeight(.semibold)
                                                .font(.body)
                                        }
                                        .buttonStyle(ThreeD())
                                        .disabled(!gewuerfelt)
                                        .opacity(!gewuerfelt ? 0.3 : 1)
                                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                                    }
                                    else {
                                        HStack {
                                            Button(action: {
                                                gewuerfelt = false
                                                valueHidden = 0
                                                value2Hidden = 0
                                                withAnimation(.spring()) {
                                                    choose = false
                                                }
                                                withAnimation(.linear(duration: 1).delay(10)) {
                                                    showTippen = true
                                                }
                                                
                                            }) {
                                                Text("Stimmt")
                                                    .fontWeight(.semibold)
                                                    .font(.body)
                                                    .foregroundColor(Color.black)
                                            }
                                            .buttonStyle(ThreeDGreen())
                                            .disabled(delayEnable)
                                            .opacity(delayEnable ? 0.3 : 1)
                                            .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.08)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                gewuerfelt = false
                                                withAnimation(.spring()) {
                                                    value = valueHidden
                                                    value2 = value2Hidden
                                                    choose = false
                                                }
                                                withAnimation(.linear(duration: 1).delay(10)) {
                                                    showTippen = true
                                                }
                                            }) {
                                                Text("Stimmt nicht")
                                                    .fontWeight(.semibold)
                                                    .font(.body)
                                                    .foregroundColor(Color.black)
                                            }
                                            .buttonStyle(ThreeDRed())
                                            .disabled(delayEnable)
                                            .opacity(delayEnable ? 0.3 : 1)
                                            .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.08)
                                        }
                                    }
                                    
                                }
                                .opacity(visibleTrinkzahl ? 0 : 1)
                                
                                VStack(){
                                    Spacer()
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
                                            Spacer()
                                            Text("Trinke \(randomTrinkzahl) Schluck/e!")
                                                .fontWeight(.semibold)
                                                .font(.title)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                    .frame(height: geo.size.height * 0.5)
                                    .padding(.bottom)
                                    .shadow(radius: 5, y: 4)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        offset = -5
                                        withAnimation(.spring()) {
                                            visibleTrinkzahl = false
                                            choose = false
                                        }
                                    })
                                    {
                                        Text("Schließen")
                                            .fontWeight(.semibold)
                                            .font(.body)
                                    }
                                    .buttonStyle(ThreeD())
                                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.08)
                                }
                                .opacity(visibleTrinkzahl ? 1 : 0)
                                
                            }
                            .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.94)
//                            .padding(.horizontal)
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
        .navigationBarTitle("Mäxchen")
    }
    
    func wuerfeln() {
        if !rolling {
            if !gewuerfelt {
                rolling = true
                delayEnable = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    rolling = false
                    withAnimation(.spring()) {
                        gewuerfelt = true
                    }
                }
                self.angle = 0.0
                for i in 0..<55 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.05) {
                        if i < 54 {
                            value = 1 + (i % 6)
                            value2 = 1 + (i % 6)
                        }
                        else {
                            value = Int.random(in: 1...6)
                            value2 = Int.random(in: 1...6)
                        }
                    }
                }
                withAnimation(.linear(duration: 1)) {
                    scale = 1.5
                }
                withAnimation(.linear(duration: 1).delay(1)) {
                    scale = 1
                }
                withAnimation(.spring(response: 1, dampingFraction: 1.5, blendDuration: 3).speed(1.2)) {
                    angle = 360.0 * 2
                }
            }
        }
    }
}

struct MaexchenView_Previews: PreviewProvider {
    static var previews: some View {
        MaexchenView()
    }
}
