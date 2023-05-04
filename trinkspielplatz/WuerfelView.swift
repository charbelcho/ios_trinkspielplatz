//
//  WuerfelView.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 20.04.23.
//

import SwiftUI

struct WuerfelView: View {
    let gui = Gui()
    @State private var showAnleitung = false
    
    @State var nWuerfel = 6
    @State var visibleTrinkzahl: Bool = false
    @State var randomTrinkzahl: Int = 0
    @State var settings: Bool = false
    
    @State private var rolling: Bool = false
    
    @State private var valueArr: [Int] = [1,1,1,1,1,1,1,1,1,1,1,1]
    @State private var scaleArr: [CGFloat] = [1,1,1,1,1,1,1,1,1,1,1,1]
    @State private var angleArr: [Double] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    @State private var saveArr: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false]
    
    @State private var scale: CGFloat = 1
    @State private var scale2: CGFloat = 1
    @State private var angle: Double = 0
    
    @State private var openAlert = false
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    Color("bluegray")
                        .ignoresSafeArea(.all, edges: [.bottom, .trailing])
                    RoundedRectangle(cornerRadius: gui.cornerRadius25)
                        .fill(.white)
                        .frame(width: geo.size.width , height: geo.size.height)
                        .overlay(
                            ZStack{
                                VStack{
                                    HStack(alignment: .top){
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
                                        
                                        Button(action: {
                                            if !rolling {
                                                if !saveArr.contains(false) {
                                                    saveArr = [false, false, false, false, false, false, false, false, false, false, false, false]
                                                }
                                                else {
                                                    saveArr = [true, true, true, true, true, true, true, true, true, true, true, true]
                                                }
                                            }
                                        }) {
                                            Text("Alle wählen/entfernen")
                                                .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.08)
                                                .padding(.all, 5.0)
                                        }
                                        .buttonStyle(ThreeD())
                                        .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.08)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            withAnimation(.spring()) {
                                                settings = true
                                            }
                                        }) {
                                            Image(systemName: "gear")
                                                .fontWeight(.semibold)
                                                .font(.title)
                                                .padding(.all, 2.0)
                                        }
                                        .buttonStyle(ThreeD())
                                        .frame(width: geo.size.width * 0.08, height: geo.size.width * 0.08)
                                        
                                    }
                                    .padding(.all, 10.0)
                                    .padding(.horizontal, 15.0)
                                    .frame(width: geo.size.width)
                                    .hidden(visibleTrinkzahl || settings)
                                    
                                    Group{
                                        Spacer()
                                        
                                        HStack {
                                            Spacer()
                                            Image("wuerfel-\(valueArr[0])-\(saveArr[0] ? "green" : "black")")
                                                .resizable()
                                                .aspectRatio(1, contentMode: .fit)
                                                .frame(width: geo.size.width * 0.2)
                                                .rotationEffect(.degrees(angleArr[0]))
                                                .scaleEffect(nWuerfel == 1 ? 2.5 : nWuerfel == 2 ? 1.5 : scaleArr[0])
                                                .shadow(radius: 10)
                                                .onTapGesture {
                                                    if !rolling {
                                                        saveArr[0] = !saveArr[0]
                                                    }
                                                }
                                            if nWuerfel > 1 {
                                                Spacer()
                                                Image("wuerfel-\(valueArr[1])-\(saveArr[1] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[1]))
                                                    .scaleEffect(nWuerfel == 2 ? 1.5 : scaleArr[1])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[1] = !saveArr[1]
                                                        }
                                                    }
                                            }
                                            
                                            if nWuerfel > 2 {
                                                Spacer()
                                                Image("wuerfel-\(valueArr[2])-\(saveArr[2] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[2]))
                                                    .scaleEffect(scaleArr[2])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[2] = !saveArr[2]
                                                        }
                                                    }
                                            }
                                            
                                            Spacer()
                                        }
                                        
                                        if nWuerfel > 3 {
                                            Spacer()
                                            
                                            HStack {
                                                Spacer()
                                                Image("wuerfel-\(valueArr[3])-\(saveArr[3] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[3]))
                                                    .scaleEffect(scaleArr[3])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[3] = !saveArr[3]
                                                        }
                                                    }
                                                    .hidden(nWuerfel < 4)

                                                Spacer()
                                                Image("wuerfel-\(valueArr[4])-\(saveArr[4] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[4]))
                                                    .scaleEffect(scaleArr[4])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[4] = !saveArr[4]
                                                        }
                                                    }
                                                    .hidden(nWuerfel < 5)

                                                Spacer()
                                                Image("wuerfel-\(valueArr[5])-\(saveArr[5] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[5]))
                                                    .scaleEffect(scaleArr[5])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[5] = !saveArr[5]
                                                        }
                                                    }
                                                    .hidden(nWuerfel < 6)

                                                Spacer()
                                            }
                                        }

                                        if nWuerfel > 6 {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Image("wuerfel-\(valueArr[6])-\(saveArr[6] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[6]))
                                                    .scaleEffect(scaleArr[6])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[6] = !saveArr[6]
                                                        }
                                                    }
                                                    .hidden(nWuerfel < 7)

                                                Spacer()
                                                Image("wuerfel-\(valueArr[7])-\(saveArr[7] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[7]))
                                                    .scaleEffect(scaleArr[7])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[7] = !saveArr[7]
                                                        }
                                                    }
                                                    .hidden(nWuerfel < 8)

                                                Spacer()
                                                Image("wuerfel-\(valueArr[8])-\(saveArr[8] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[8]))
                                                    .scaleEffect(scaleArr[8])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[8] = !saveArr[8]
                                                        }
                                                    }
                                                    .hidden(nWuerfel < 9)

                                                Spacer()
                                            }
                                        }

                                        if nWuerfel > 9 {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Image("wuerfel-\(valueArr[9])-\(saveArr[9] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[9]))
                                                    .scaleEffect(scaleArr[9])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[9] = !saveArr[9]
                                                        }
                                                    }
                                                    .hidden(nWuerfel < 10)

                                                Spacer()
                                                Image("wuerfel-\(valueArr[10])-\(saveArr[10] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[10]))
                                                    .scaleEffect(scaleArr[10])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[10] = !saveArr[10]
                                                        }
                                                    }
                                                    .hidden(nWuerfel < 11)

                                                Spacer()

                                                Image("wuerfel-\(valueArr[11])-\(saveArr[11] ? "green" : "black")")
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.2)
                                                    .rotationEffect(.degrees(angleArr[11]))
                                                    .scaleEffect(scaleArr[11])
                                                    .shadow(radius: 10)
                                                    .onTapGesture {
                                                        if !rolling {
                                                            saveArr[11] = !saveArr[11]
                                                        }
                                                    }
                                                    .hidden(nWuerfel < 12)

                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                    }
                                    .hidden(visibleTrinkzahl || settings)

                                    Button(action: {
                                        wuerfeln()
                                    }) {
                                        Text("Würfeln")
                                            .fontWeight(.semibold)
                                            .font(.body)
                                    }
                                    .buttonStyle(ThreeD())
                                    .frame(width: geo.size.width * 0.90, height: geo.size.height * 0.08)
                                    .hidden(visibleTrinkzahl || settings)

                                }
                                
                                VStack{
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
                                            
                                            
                                            Text("Anzahl Würfel")
                                                .fontWeight(.semibold)
                                                .font(.title3)
                                                .padding()
                                            
                                            Picker("Anzahl Würfel", selection: $nWuerfel) {
                                                ForEach(1...12, id: \.self) { number in
                                                        Text("\(number)")
                                                }
                                            }
                                            .pickerStyle(.wheel)
                                            .background(Color.gray.opacity(0.05))
                                            .accentColor(Color.blue)
                                            
                                            Button(action: {
                                                settings = false
                                            })
                                            {
                                                Text("Speichern")
                                                    .fontWeight(.semibold)
                                                    .font(.body)
                                            }
                                            .buttonStyle(ThreeD())
                                            .frame(width: geo.size.width * 0.85, height: geo.size.height * 0.08)
                                            .padding(.bottom, 5.0)
                                            
                                        }
                                        .padding(.horizontal)
                                        .padding(.bottom)
                                    }
                                    .frame(height: geo.size.height * 0.55)
                                    .padding(.horizontal)
                                    .shadow(radius: 5, y: 4)
                                    
                                    
                                    
                                    Spacer()
                                }
                                .hidden(!settings)
                                
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
                                        visibleTrinkzahl = false
                                    })
                                    {
                                        Text("Schließen")
                                            .fontWeight(.semibold)
                                            .font(.body)
                                    }
                                    .buttonStyle(ThreeD())
                                    .frame(width: geo.size.width * 0.90, height: geo.size.height * 0.08)
                                }
                                .hidden(!visibleTrinkzahl)

                            }
                            .frame(height: geo.size.height * 0.94)
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
        .navigationBarTitle("Würfel")
    }
    
    func wuerfeln() {
        if !rolling {
            rolling = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                rolling = false
            }
            self.angleArr = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
            for i in 0..<55 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.05) {
                    if i < 54 {
                        for j in 0..<valueArr.count {
                            if !saveArr[j] {
                                valueArr[j] = 1 + (i % 6)
                            }
                            else {
                                valueArr[j] = valueArr[j]
                            }
                        }
                    }
                    else {
                        for j in 0..<valueArr.count - 1 {
                            if !saveArr[j] {
                                valueArr[j] = Int.random(in: 1...6)
                            }
                        }
                    }
                }
            }
            
            for j in 0..<valueArr.count {
                if !saveArr[j] {
                    withAnimation(.linear(duration: 1)) {
                        scaleArr[j] = 1.2
                    }
                    withAnimation(.linear(duration: 1).delay(1)) {
                        scaleArr[j] = 1
                    }
                    withAnimation(.spring(response: 1, dampingFraction: 1.5, blendDuration: 3).speed(1.2)) {
                        angleArr[j] = 360.0 * 2
                    }
                }
                else {
                    withAnimation(.linear(duration: 1)) {
                        scaleArr[j] = 1
                    }
                    withAnimation(.linear(duration: 1).delay(1)) {
                        scaleArr[j] = 1
                    }
                    withAnimation(.spring(response: 1, dampingFraction: 1.5, blendDuration: 3).speed(1.2)) {
                        angleArr[j] = 0
                    }
                }
            }
        }
    }
}

struct WuerfelView_Previews: PreviewProvider {
    static var previews: some View {
        WuerfelView()
    }
}
