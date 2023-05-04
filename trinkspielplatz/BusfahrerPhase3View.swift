//
//  BusfahrerPhase3View.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 24.01.23.
//

import SwiftUI

struct BusfahrerPhase3View: View {
    @ObservedObject var service: ServiceBusfahrer
    
    var array: [Card] =  DataLoader().cardArray
    @State var correct = ""
    @Binding var correctInRow: Int
    @Binding var random: [Card]
    @State var n = 0
    
    let gui = Gui()
    
    var body: some View {
        GeometryReader { geo in
            VStack() {
                Text("Busfahrer: \(service.busfahrer)")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
                
                ZStack {
                    if n < 50 {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("gray"))
                            .offset(x: 6, y: 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("bluegray"), lineWidth: 1)
                                    .offset(x: 6, y: 6)
                            )
                            .frame(width: geo.size.width * 0.30, height: geo.size.width * 0.45)
                            .shadow(radius: 5, y: 4)
                    }
                    
                    if n < 51 {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("gray"))
                            .offset(x: 3, y: 3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("bluegray"), lineWidth: 1)
                                    .offset(x: 3, y: 3)
                            )
                            .frame(width: geo.size.width * 0.30, height: geo.size.width * 0.45)
                            .shadow(radius: n == 50 ? 5 : 0, y: n == 50 ? 4 : 0)
                    }
                    
                    Image("png/\(random[safe: n]?.card ?? "back2")")
                        .resizable()
                        .frame(width: geo.size.width * 0.30, height: geo.size.width * 0.45)
                        .shadow(radius: n == 51 ? 5 : 0, y: n == 51 ? 4 : 0)
                }
                
                HStack {
                    Text(correct == "Richtig" ? "\(correct)" : "Falsch")
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .background(correct == "Richtig" ? Color.green : Color.red)
                        .cornerRadius(gui.cornerRadius25)
                        .font(.body)
                        .shadow(radius: 10)
                        .opacity(correct.count > 0 ? 1 : 0)
                    
                    Text("Richtig in Folge: \(correctInRow)")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .font(.headline)
                }
                
                HStack {
                    if n == 51 {
                        Spacer()
                        Button(action: {
                            random = array.shuffled()
                            withAnimation(.spring()) {
                                n = 0
                            }
                        }) {
                            Text("Neu starten")
                                .fontWeight(.semibold)
                                .font(.body)
                                .padding(.all, 8.0)
                        }
                        .buttonStyle(ThreeD())
                        .frame(width: geo.size.width * 0.85, height: geo.size.height * 0.08)
                        .padding(.vertical, 7.0)
                        
                        Spacer()
                    }
                    else {
                        Spacer()
                        Button(action: {
                            withAnimation(.spring()) {
                                n += 1
                            }
                            if random[safe: n - 1]?.value ?? 0 < random[safe: n]?.value ?? 0 {
                                withAnimation(.spring()) {
                                    correct = "Richtig"
                                    correctInRow = correctInRow + 1
                                }
                            }
                            else {
                                correct = "Falsch!"
                                withAnimation(.spring()) {
                                    correctInRow = 0
                                }
                            }
                        }) {
                            Image(systemName: "arrow.up")
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                                .font(.headline)
                        }
                        .buttonStyle(ThreeD())
                        .frame(width: 80, height: 40)
                        .disabled(correctInRow == 5)
                        .opacity(correctInRow == 5 ? 0 : 1)
                        
                        Spacer()
                        Button(action: {
                            withAnimation(.spring()) {
                                n += 1
                            }
                            if random[safe: n - 1]?.value ?? 0 == random[safe: n]?.value ?? 0  {
                                withAnimation(.spring()) {
                                    correct = "Richtig"
                                    correctInRow = correctInRow + 1
                                }
                            }
                            else {
                                correct = "Falsch!"
                                withAnimation(.spring()) {
                                    correctInRow = 0
                                }
                            }
                        }) {
                            Text("=")
                                .fontWeight(.semibold)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                                .font(.headline)
                        }
                        .buttonStyle(ThreeD())
                        .frame(width: 80, height: 40)
                        .disabled(correctInRow == 5)
                        .opacity(correctInRow == 5 ? 0 : 1)
                        
                        Spacer()
                        Button(action: {
                            withAnimation(.spring()) {
                                n += 1
                            }
                            if random[safe: n - 1]?.value ?? 0 > random[safe: n]?.value ?? 0 {
                                withAnimation(.spring()) {
                                    correct = "Richtig"
                                    correctInRow = correctInRow + 1
                                }
                            }
                            else {
                                correct = "Falsch!"
                                withAnimation(.spring()) {
                                    correctInRow = 0
                                }
                            }
                        }) {
                            Image(systemName: "arrow.down")
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10.0)
                                .font(.headline)
                        }
                        .buttonStyle(ThreeD())
                        .frame(width: 80, height: 40)
                        .disabled(correctInRow == 5)
                        .opacity(correctInRow == 5 ? 0 : 1)
                        
                        Spacer()
                    }
                }
            }
            .frame(height: geo.size.height)
        }
        
    }
}

//struct BusfahrerPhase3View_Previews: PreviewProvider {
//    static var previews: some View {
//        BusfahrerPhase3View(service: ServiceBusfahrer(), correctInRow: .constant(0), random: [Card]())
//    }
//}
