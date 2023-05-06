//
//  DataLoader.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 04.05.23.
//

import Foundation
import SwiftUI

public class DataLoader {
    @Published var nochnieData = [NochnieData]()
    @Published var nochnieArray: [String] = []
    @Published var eherData = [EherData]()
    @Published var eherArray: [String] = []
    @Published var wahrheitData = [WahrheitData]()
    @Published var wahrheitArray: [String] = []
    @Published var pflichtData = [PflichtData]()
    @Published var pflichtArray: [String] = []
    @Published var cardArray = [
        Card(id: 0, card: "herz2", value: 2, colour: "rot", zeichen: "herz"),
        Card(id: 1, card: "herz3", value: 3, colour: "rot", zeichen: "herz"),
        Card(id: 2, card: "herz4", value: 4, colour: "rot", zeichen: "herz"),
        Card(id: 3, card: "herz5", value: 5, colour: "rot", zeichen: "herz"),
        Card(id: 4, card: "herz6", value: 6, colour: "rot", zeichen: "herz"),
        Card(id: 5, card: "herz7", value: 7, colour: "rot", zeichen: "herz"),
        Card(id: 6, card: "herz8", value: 8, colour: "rot", zeichen: "herz"),
        Card(id: 7, card: "herz9", value: 9, colour: "rot", zeichen: "herz"),
        Card(id: 8, card: "herz10", value: 10, colour: "rot", zeichen: "herz"),
        Card(id: 9, card: "herzj", value: 11, colour: "rot", zeichen: "herz"),
        Card(id: 10, card: "herzq", value: 12, colour: "rot", zeichen: "herz"),
        Card(id: 11, card: "herzk", value: 13, colour: "rot", zeichen: "herz"),
        Card(id: 12, card: "herza", value: 14, colour: "rot", zeichen: "herz"),
        Card(id: 13, card: "kreuz2", value: 2, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 14, card: "kreuz3", value: 3, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 15, card: "kreuz4", value: 4, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 16, card: "kreuz5", value: 5, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 17, card: "kreuz6", value: 6, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 18, card: "kreuz7", value: 7, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 19, card: "kreuz8", value: 8, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 20, card: "kreuz9", value: 9, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 21, card: "kreuz10", value: 10, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 22, card: "kreuzj", value: 11, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 23, card: "kreuzq", value: 12, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 24, card: "kreuzk", value: 13, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 25, card: "kreuza", value: 14, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 26, card: "karo2", value: 2, colour: "rot", zeichen: "karo"),
        Card(id: 27, card: "karo3", value: 3, colour: "rot", zeichen: "karo"),
        Card(id: 28, card: "karo4", value: 4, colour: "rot", zeichen: "karo"),
        Card(id: 29, card: "karo5", value: 5, colour: "rot", zeichen: "karo"),
        Card(id: 30, card: "karo6", value: 6, colour: "rot", zeichen: "karo"),
        Card(id: 31, card: "karo7", value: 7, colour: "rot", zeichen: "karo"),
        Card(id: 32, card: "karo8", value: 8, colour: "rot", zeichen: "karo"),
        Card(id: 33, card: "karo9", value: 9, colour: "rot", zeichen: "karo"),
        Card(id: 34, card: "karo10", value: 10, colour: "rot", zeichen: "karo"),
        Card(id: 35, card: "karoj", value: 11, colour: "rot", zeichen: "karo"),
        Card(id: 36, card: "karoq", value: 12, colour: "rot", zeichen: "karo"),
        Card(id: 37, card: "karok", value: 13, colour: "rot", zeichen: "karo"),
        Card(id: 38, card: "karoa", value: 14, colour: "rot", zeichen: "karo"),
        Card(id: 39, card: "pik2", value: 2, colour: "schwarz", zeichen: "pik"),
        Card(id: 40, card: "pik3", value: 3, colour: "schwarz", zeichen: "pik"),
        Card(id: 41, card: "pik4", value: 4, colour: "schwarz", zeichen: "pik"),
        Card(id: 42, card: "pik5", value: 5, colour: "schwarz", zeichen: "pik"),
        Card(id: 43, card: "pik6", value: 6, colour: "schwarz", zeichen: "pik"),
        Card(id: 44, card: "pik7", value: 7, colour: "schwarz", zeichen: "pik"),
        Card(id: 45, card: "pik8", value: 8, colour: "schwarz", zeichen: "pik"),
        Card(id: 46, card: "pik9", value: 9, colour: "schwarz", zeichen: "pik"),
        Card(id: 47, card: "pik10", value: 10, colour: "schwarz", zeichen: "pik"),
        Card(id: 48, card: "pikj", value: 11, colour: "schwarz", zeichen: "pik"),
        Card(id: 49, card: "pikq", value: 12, colour: "schwarz", zeichen: "pik"),
        Card(id: 50, card: "pikk", value: 13, colour: "schwarz", zeichen: "pik"),
        Card(id: 51, card: "pika", value: 14, colour: "schwarz", zeichen: "pik")
    ]
    @Published var pferderennenStartCardArray: [Card] = []
    
    @Published var pferderennenCardArray = [
        Card(id: 0, card: "herz2", value: 2, colour: "rot", zeichen: "herz"),
        Card(id: 1, card: "herz3", value: 3, colour: "rot", zeichen: "herz"),
        Card(id: 2, card: "herz4", value: 4, colour: "rot", zeichen: "herz"),
        Card(id: 3, card: "herz5", value: 5, colour: "rot", zeichen: "herz"),
        Card(id: 4, card: "herz6", value: 6, colour: "rot", zeichen: "herz"),
        Card(id: 5, card: "herz7", value: 7, colour: "rot", zeichen: "herz"),
        Card(id: 6, card: "herz8", value: 8, colour: "rot", zeichen: "herz"),
        Card(id: 7, card: "herz9", value: 9, colour: "rot", zeichen: "herz"),
        Card(id: 8, card: "herz10", value: 10, colour: "rot", zeichen: "herz"),
        Card(id: 9, card: "herzj", value: 11, colour: "rot", zeichen: "herz"),
        Card(id: 10, card: "herzq", value: 12, colour: "rot", zeichen: "herz"),
        Card(id: 11, card: "herzk", value: 13, colour: "rot", zeichen: "herz"),
        Card(id: 13, card: "kreuz2", value: 2, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 14, card: "kreuz3", value: 3, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 15, card: "kreuz4", value: 4, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 16, card: "kreuz5", value: 5, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 17, card: "kreuz6", value: 6, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 18, card: "kreuz7", value: 7, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 19, card: "kreuz8", value: 8, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 20, card: "kreuz9", value: 9, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 21, card: "kreuz10", value: 10, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 22, card: "kreuzj", value: 11, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 23, card: "kreuzq", value: 12, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 24, card: "kreuzk", value: 13, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 26, card: "karo2", value: 2, colour: "rot", zeichen: "karo"),
        Card(id: 27, card: "karo3", value: 3, colour: "rot", zeichen: "karo"),
        Card(id: 28, card: "karo4", value: 4, colour: "rot", zeichen: "karo"),
        Card(id: 29, card: "karo5", value: 5, colour: "rot", zeichen: "karo"),
        Card(id: 30, card: "karo6", value: 6, colour: "rot", zeichen: "karo"),
        Card(id: 31, card: "karo7", value: 7, colour: "rot", zeichen: "karo"),
        Card(id: 32, card: "karo8", value: 8, colour: "rot", zeichen: "karo"),
        Card(id: 33, card: "karo9", value: 9, colour: "rot", zeichen: "karo"),
        Card(id: 34, card: "karo10", value: 10, colour: "rot", zeichen: "karo"),
        Card(id: 35, card: "karoj", value: 11, colour: "rot", zeichen: "karo"),
        Card(id: 36, card: "karoq", value: 12, colour: "rot", zeichen: "karo"),
        Card(id: 37, card: "karok", value: 13, colour: "rot", zeichen: "karo"),
        Card(id: 39, card: "pik2", value: 2, colour: "schwarz", zeichen: "pik"),
        Card(id: 40, card: "pik3", value: 3, colour: "schwarz", zeichen: "pik"),
        Card(id: 41, card: "pik4", value: 4, colour: "schwarz", zeichen: "pik"),
        Card(id: 42, card: "pik5", value: 5, colour: "schwarz", zeichen: "pik"),
        Card(id: 43, card: "pik6", value: 6, colour: "schwarz", zeichen: "pik"),
        Card(id: 44, card: "pik7", value: 7, colour: "schwarz", zeichen: "pik"),
        Card(id: 45, card: "pik8", value: 8, colour: "schwarz", zeichen: "pik"),
        Card(id: 46, card: "pik9", value: 9, colour: "schwarz", zeichen: "pik"),
        Card(id: 47, card: "pik10", value: 10, colour: "schwarz", zeichen: "pik"),
        Card(id: 48, card: "pikj", value: 11, colour: "schwarz", zeichen: "pik"),
        Card(id: 49, card: "pikq", value: 12, colour: "schwarz", zeichen: "pik"),
        Card(id: 50, card: "pikk", value: 13, colour: "schwarz", zeichen: "pik")
    ]
    
    @Published var herzCardArray = [
        Card(id: 0, card: "herz2", value: 2, colour: "rot", zeichen: "herz"),
        Card(id: 1, card: "herz3", value: 3, colour: "rot", zeichen: "herz"),
        Card(id: 2, card: "herz4", value: 4, colour: "rot", zeichen: "herz"),
        Card(id: 3, card: "herz5", value: 5, colour: "rot", zeichen: "herz"),
        Card(id: 4, card: "herz6", value: 6, colour: "rot", zeichen: "herz"),
        Card(id: 5, card: "herz7", value: 7, colour: "rot", zeichen: "herz"),
        Card(id: 6, card: "herz8", value: 8, colour: "rot", zeichen: "herz"),
        Card(id: 7, card: "herz9", value: 9, colour: "rot", zeichen: "herz"),
        Card(id: 8, card: "herz10", value: 10, colour: "rot", zeichen: "herz"),
        Card(id: 9, card: "herzj", value: 11, colour: "rot", zeichen: "herz"),
        Card(id: 10, card: "herzq", value: 12, colour: "rot", zeichen: "herz"),
        Card(id: 11, card: "herzk", value: 13, colour: "rot", zeichen: "herz"),
        Card(id: 12, card: "herza", value: 14, colour: "rot", zeichen: "herz")
    ]
    
    @Published var kreuzCardArray = [
        Card(id: 13, card: "kreuz2", value: 2, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 14, card: "kreuz3", value: 3, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 15, card: "kreuz4", value: 4, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 16, card: "kreuz5", value: 5, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 17, card: "kreuz6", value: 6, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 18, card: "kreuz7", value: 7, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 19, card: "kreuz8", value: 8, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 20, card: "kreuz9", value: 9, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 21, card: "kreuz10", value: 10, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 22, card: "kreuzj", value: 11, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 23, card: "kreuzq", value: 12, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 24, card: "kreuzk", value: 13, colour: "schwarz", zeichen: "kreuz"),
        Card(id: 25, card: "kreuza", value: 14, colour: "schwarz", zeichen: "kreuz")
    ]
    
    @Published var karoCardArray = [
        Card(id: 26, card: "karo2", value: 2, colour: "rot", zeichen: "karo"),
        Card(id: 27, card: "karo3", value: 3, colour: "rot", zeichen: "karo"),
        Card(id: 28, card: "karo4", value: 4, colour: "rot", zeichen: "karo"),
        Card(id: 29, card: "karo5", value: 5, colour: "rot", zeichen: "karo"),
        Card(id: 30, card: "karo6", value: 6, colour: "rot", zeichen: "karo"),
        Card(id: 31, card: "karo7", value: 7, colour: "rot", zeichen: "karo"),
        Card(id: 32, card: "karo8", value: 8, colour: "rot", zeichen: "karo"),
        Card(id: 33, card: "karo9", value: 9, colour: "rot", zeichen: "karo"),
        Card(id: 34, card: "karo10", value: 10, colour: "rot", zeichen: "karo"),
        Card(id: 35, card: "karoj", value: 11, colour: "rot", zeichen: "karo"),
        Card(id: 36, card: "karoq", value: 12, colour: "rot", zeichen: "karo"),
        Card(id: 37, card: "karok", value: 13, colour: "rot", zeichen: "karo"),
        Card(id: 38, card: "karoa", value: 14, colour: "rot", zeichen: "karo")
    ]
    
    @Published var pikCardArray = [
        Card(id: 39, card: "pik2", value: 2, colour: "schwarz", zeichen: "pik"),
        Card(id: 40, card: "pik3", value: 3, colour: "schwarz", zeichen: "pik"),
        Card(id: 41, card: "pik4", value: 4, colour: "schwarz", zeichen: "pik"),
        Card(id: 42, card: "pik5", value: 5, colour: "schwarz", zeichen: "pik"),
        Card(id: 43, card: "pik6", value: 6, colour: "schwarz", zeichen: "pik"),
        Card(id: 44, card: "pik7", value: 7, colour: "schwarz", zeichen: "pik"),
        Card(id: 45, card: "pik8", value: 8, colour: "schwarz", zeichen: "pik"),
        Card(id: 46, card: "pik9", value: 9, colour: "schwarz", zeichen: "pik"),
        Card(id: 47, card: "pik10", value: 10, colour: "schwarz", zeichen: "pik"),
        Card(id: 48, card: "pikj", value: 11, colour: "schwarz", zeichen: "pik"),
        Card(id: 49, card: "pikq", value: 12, colour: "schwarz", zeichen: "pik"),
        Card(id: 50, card: "pikk", value: 13, colour: "schwarz", zeichen: "pik"),
        Card(id: 51, card: "pika", value: 14, colour: "schwarz", zeichen: "pik")
    ]

    init() {
        load()
        sort()
        for n in 0..<nochnieData.count {
            nochnieArray.append(nochnieData[n].text)
        }
        for n in 0..<wahrheitData.count {
            wahrheitArray.append(wahrheitData[n].text)
        }
        for n in 0..<pflichtData.count {
            pflichtArray.append(pflichtData[n].text)
        }
        for n in 0..<eherData.count {
            eherArray.append(eherData[n].text)
        }
        pferderennenCardArray = pferderennenCardArray.shuffled()
        pferderennenStartCardArray = Array(pferderennenCardArray[0..<7])
        pferderennenCardArray.removeFirst(7)
        
    }
    
    func load() {
        if let fileLocation = Bundle.main.url(forResource: "IchhabnochnieJSON", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([NochnieData].self, from: data)
                
                self.nochnieData = dataFromJson
            } catch {
                print(error)
            }
        }
        if let fileLocation2 = Bundle.main.url(forResource: "WerWuerdeEherJSON", withExtension: "json") {
            do {
                let data2 = try Data(contentsOf: fileLocation2)
                let jsonDecoder2 = JSONDecoder()
                let dataFromJson2 = try jsonDecoder2.decode([EherData].self, from: data2)
                
                self.eherData = dataFromJson2
            } catch {
                print(error)
            }
        }
        
        if let fileLocation3 = Bundle.main.url(forResource: "WahrheitJSON", withExtension: "json") {
            do {
                let data3 = try Data(contentsOf: fileLocation3)
                let jsonDecoder3 = JSONDecoder()
                let dataFromJson3 = try jsonDecoder3.decode([WahrheitData].self, from: data3)
                
                self.wahrheitData = dataFromJson3
            } catch {
                print(error)
            }
        }
        if let fileLocation4 = Bundle.main.url(forResource: "PflichtJSON", withExtension: "json") {
            do {
                let data4 = try Data(contentsOf: fileLocation4)
                let jsonDecoder4 = JSONDecoder()
                let dataFromJson4 = try jsonDecoder4.decode([PflichtData].self, from: data4)
                
                self.pflichtData = dataFromJson4
            } catch {
                print(error)
            }
        }
    }
    func sort() {
        self.nochnieData = self.nochnieData.sorted(by: { $0.text < $1.text })
        self.eherData = self.eherData.sorted(by: { $0.text < $1.text })
        self.wahrheitData = self.wahrheitData.sorted(by: { $0.text < $1.text })
        self.pflichtData = self.pflichtData.sorted(by: { $0.text < $1.text })
    }
}
