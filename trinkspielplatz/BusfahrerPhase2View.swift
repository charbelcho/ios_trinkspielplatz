//
//  BusfahrerPhase2View.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 25.01.23.
//

import SwiftUI

struct BusfahrerPhase2View: View {
    @ObservedObject var service: ServiceBusfahrer
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                HStack() {
                    VStack(){
                        Text("Meine\nKarten:")
                            .font(.system(size: 14))
                        ZStack {
                            CardFront(card: service.roomBusfahrer.deck[safe: service.meineKarten[safe: 0] ?? 0]?.card ?? "back", width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.myCardsFDegreeArray[safe: 0]!)
                            CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.myCardsBDegreeArray[0])
                            Text("\(service.trinkAnzahlArray[0])")
                                .fontWeight(.bold)
                                .font(.system(size: 20, design: .rounded))
                                .opacity(service.myCardsFlipArray[0] ? 1 : 0)
                        }

                        ZStack {
                            CardFront(card: service.roomBusfahrer.deck[safe: service.meineKarten[safe: 1] ?? 1]?.card ?? "back", width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.myCardsFDegreeArray[1])
                            CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.myCardsBDegreeArray[1])
                            Text("\(service.trinkAnzahlArray[1])")
                                .fontWeight(.bold)
                                .font(.system(size: 20, design: .rounded))
                                .opacity(service.myCardsFlipArray[1] ? 1 : 0)
                        }

                        ZStack {
                            CardFront(card: service.roomBusfahrer.deck[safe: service.meineKarten[safe: 2] ?? 2]?.card ?? "back", width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.myCardsFDegreeArray[2])
                            CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.myCardsBDegreeArray[2])
                            Text("\(service.trinkAnzahlArray[2])")
                                .fontWeight(.bold)
                                .font(.system(size: 20, design: .rounded))
                                .opacity(service.myCardsFlipArray[2] ? 1 : 0)
                        }
                        Spacer()
                    }
                    .onAppear(perform: {

                    })
                    Spacer()
                }
                .padding(.leading)

                HStack {
                    Spacer()
                    VStack {
                        HStack {
                            ZStack {
                                CardFront(card: service.roomBusfahrer.deck[safe: 14]?.card ?? "back2", width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[14])
                                CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[14])
                            }.onTapGesture {
                                if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                    service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 14, "row": 5])
                                }
                            }
                        }
                        HStack {
                            ZStack {
                                CardFront(card: service.roomBusfahrer.deck[safe: 12]?.card ?? "back2", width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[12])
                                CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[12])
                            }.onTapGesture {
                                if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                    service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 12, "row": 4])
                                }
                            }
                            ZStack {
                                CardFront(card: service.roomBusfahrer.deck[safe: 13]?.card ?? "back2", width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[13])
                                CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[13])
                            }.onTapGesture {
                                if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                    service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 13, "row": 4])
                                }
                            }
                        }
                        HStack {
                            ZStack {
                                CardFront(card: service.roomBusfahrer.deck[safe: 9]?.card ?? "back2", width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[9])
                                CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[9])
                            }.onTapGesture {
                                if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                    service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 9, "row": 3])
                                }
                            }
                            ZStack {
                                CardFront(card: service.roomBusfahrer.deck[safe: 10]?.card ?? "back2" ,width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[10])
                                CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[10])
                            }.onTapGesture {
                                if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                    service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 10, "row": 3])
                                }
                            }
                            ZStack {
                                CardFront(card: service.roomBusfahrer.deck[safe: 11]?.card ?? "back2" ,width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[11])
                                CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[11])
                            }.onTapGesture {
                                if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                    service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 11, "row": 3])
                                }
                            }
                        }
                        HStack {
                            ZStack {
                                CardFront(card: service.roomBusfahrer.deck[safe: 5]?.card ?? "back2" ,width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[5])
                                CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[5])
                            }.onTapGesture {
                                if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                    service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 5, "row": 2])
                                }
                            }
                            ZStack {
                                CardFront(card: service.roomBusfahrer.deck[safe: 6]?.card ?? "back2" ,width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[6])
                                CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[6])
                            }.onTapGesture {
                                if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                    service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 6, "row": 2])
                                }
                            }
                            ZStack {
                                CardFront(card: service.roomBusfahrer.deck[safe: 7]?.card ?? "back2" ,width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[7])
                                CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[7])
                            }.onTapGesture {
                                if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                    service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 7, "row": 2])
                                }
                            }
                            ZStack {
                                CardFront(card: service.roomBusfahrer.deck[safe: 8]?.card ?? "back2" ,width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[8])
                                CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[8])
                            }.onTapGesture {
                                if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                    service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 8, "row": 2])
                                }
                            }
                        }
                        HStack {
                            Group {
                                ZStack {
                                    CardFront(card: service.roomBusfahrer.deck[safe: 0]?.card ?? "back2" ,width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[0])
                                    CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[0])
                                }.onTapGesture {
                                    if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                        service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 0, "row": 1])
                                    }
                                }
                                ZStack {
                                    CardFront(card: service.roomBusfahrer.deck[safe: 1]?.card ?? "back2" ,width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[1])
                                    CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[1])
                                }.onTapGesture {
                                    if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                        service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 1, "row": 1])
                                    }
                                }
                                ZStack {
                                    CardFront(card: service.roomBusfahrer.deck[safe: 2]?.card ?? "back2",width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[2])
                                    CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[2])
                                }.onTapGesture {
                                    if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                        service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 2, "row": 1])
                                    }
                                }
                                ZStack {
                                    CardFront(card: service.roomBusfahrer.deck[safe: 3]?.card ?? "back2" ,width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[3])
                                    CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[3])
                                }.onTapGesture {
                                    if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                        service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 3, "row": 1])
                                    }
                                }
                                ZStack {
                                    CardFront(card: service.roomBusfahrer.deck[safe: 4]?.card ?? "back2" ,width: geo.size.width * 0.1 , height: geo.size.width * 0.15, degree: $service.fDegreeArray[4])
                                    CardBack(width: geo.size.width * 0.1, height: geo.size.width * 0.15, degree: $service.bDegreeArray[4])
                                }.onTapGesture {
                                    if service.roomBusfahrer.users[safe: 0]?.username == service.busfahrerUsername {
                                        service.karteDrehen(socketData: ["roomId": service.roomBusfahrer.roomId, "index": 4, "row": 1])
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.trailing)
            }
        }
    }
}

struct BusfahrerPhase2View_Previews: PreviewProvider {
    static var previews: some View {
        BusfahrerPhase2View(service: ServiceBusfahrer())
    }
}
