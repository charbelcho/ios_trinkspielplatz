//
//  AnleitungenView.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 27.12.21.
//

import SwiftUI

struct Anleitung: Identifiable {
    let id = UUID()
    let name: String
    var items: [Anleitung]?

    // some example websites
    static let nochnieAnleitung = Anleitung(name: """
        Ein Spieler liest die angezeigte Frage vor. Alle Spieler, die die Frage mit "ja, habe ich schon mal" beantworten können, trinken einen Schluck.
        """)
    static let eherAnleitung = Anleitung(name: """
        Ein Spieler liest die angezeigte Frage vor. Die Spieler überlegen auf wen der Mitspieler die Frage am ehesten zutrifft. Sie zeigen auf den jeweiligen Spieler und dieser trinkt die Anzahl an Schlucken von seinem Drink. Jeder kann auf einen beliebigen Spieler zeigen.
        """)
    static let wahrheitPflichtAnleitung = Anleitung(name: """
        Der Spieler an der Reihe entscheidet sich zwischen Wahrheit oder Pflicht und tippt auf das Feld. Beantwortet die Person die Frage oder macht die Aufgabe, darf ein Schluck vergeben werden. Wird es nicht gemacht tippt man auf den Bier-Button und trinkt die angezeigte Anzahl an Schlucken.
        """)
    static let hoeherTieferAnleitung = Anleitung(name: """
        Der Spieler an der Reihe entscheidet, ob die nächste Karte höher, gleich oder tiefer ist, als die angezeigte Karte. Ist der Versuch falsch muss der Spieler einen Schluck trinken. Er oder sie rät so oft, bis 3 Versuche in Folge richtig sind. Dann ist der nächste Spieler dran. Wird bei einem Versuch 'Gleich' ausgewählt und dieser ist richtig, trinken alle anderen Spieler ihr Getränk auf ex.
        """)
    static let bangAnleitung = Anleitung(name: """
        Der Spieler, der verliert trinkt die angezeigte Anzahl an Schlucken. Der Spieler, der zu früh schießt, trinkt die angezeigt Anzahl an Schlucken.
        """)
    static let shitheadAnleitung = Anleitung(name: """
        Der Reihe um zieht jeder Spieler eine Karte und erfüllt die Aufgabe. Der Spieler der Captain Shithead ist, darf sich Regeln überlegen solange bis jemand anderes Captain Shithead ist.
        """)
    static let pferderennenAnleitung = Anleitung(name: """
        Die Spieler tragen sich beim Start ein und wetten ihre Schlucke auf eine Farbe. Die gewettete Schluckanzahl muss von dem Spieler selbst getrunken werden. Dann werden die Karten gezogen. Wenn ein Spieler eine Strafe bekommt, wird es in einer Meldung angezeigt.
        """)
    static let kingsCupAnleitung = Anleitung(name: """
        Der Reihe um zieht jeder Spieler eine Karte und erfüllt die Aufgabe.
        """)
    static let werbinichAnleitung = Anleitung(name: """
        Du kannst eine Gruppe erstellen oder einer Gruppe beitreten. Um einer Gruppe beitreten, gib die Raum-ID einer Gruppe ein und bestätige. Wenn du der Ersteller einer Gruppe bist, kannst du auswählen, ob zufällig Personen für die Spieler zugeteilt werden oder die Spieler sich untereinander Personen zuteilen können. Danach kann der erste Spieler anfangen Ja-Nein-Fragen zu tellen, um seine zugeteilte Person zu erreaten. Wird eine Frage mit Ja beantwortet, kann der Spieler eine weitere Frage stellen. Wird eine Frage mit Nein beantwortet, trinkt der Spieler 2 Schlucke und der nächste Spieler ist an der Reihe.
        """)
    static let busfahrerAnleitung = Anleitung(name: """
        Du kannst eine Gruppe erstellen oder einer Gruppe beitreten. Um einer Gruppe beitreten, gib die Raum-ID einer Gruppe ein und bestätige. Wenn du der Ersteller einer Gruppe bist, kannst du die Karten austeilen. Danach kannst du als Ersteller die Karten einzeln umdrehen. Ist eine aufgedrehte Karte in den Karten eines Spielers enthalten, dreht sich die Karte des Spielers automatisch um und er kann die Anzahl an Schlucken auf dem Kartenrücken verteilen. Sind alle Karten aufgedeckt, kann der Busfahren-Button gedrückt werden. Der Spieler mit den meisten offenen Karten ist Busfahrer. Auf dem Handy des Erstellers muss der Busfahrer dann "Busfahren". Immer wenn der Busfahrer einen Fehler macht muss er trinken. Wenn der Busfahrer 5 Mal richtig lag, ist das Spiel vorbei.
        """)
    static let maexchenAnleitung = Anleitung(name: """
        Der erste Spieler fängt an zu würfeln. Er sagt den Wert des Wurfes an und darf dabei auch lügen. Danach gibt er das Handy an den nächsten Spieler. Dieser wählt ob er dem Vorspieler glaubt oder nicht. Glaubt er ihm, würfelt er ohne den Wert des Wurfes vom Vorspieler zu kennen. Egal was er würfelt, sein angesagter Wert muss höher sein als der zuvor angesagte, er kann auch lügen. Wenn er ihm nicht glaubt, deckt er mit "Stimmt nicht" die Würfel auf. Stimmt der angesagte Wert nicht, muss der Vorspieler den Bier-Button tippen und die Anzahl an Schlucken trinken, stimmt der angesagte Wert aber doch, muss der Spieler selbst den Bier-Button tippen und die Anzahl an Schlucken trinken. Die Runde ist fertig wenn ein Spieler glaubt dass sein Vorspieler gelogen hat oder keine Wertsteigerung mehr möglich ist. Der Gewinner der Runde beginnt die nächste.
        """)
    static let einhundertAnleitung = Anleitung(name: """
        Füge die Spieler hinzu. Der erste Spieler fängt an zu würfeln. Er kann so lange Würfeln wie er möchte, die Punkte werden zusammen gezählt. Er kann jederzeit seinen Punktestand speichern. Dann ist der nächste Spieler dran. Würfelt der Spieler eine 6 fällt er auf seinen zuletzt gespeicherten Punkestand zurück. Ein Spieler hat gewonnen sobald er 100 oder mehr Punkte gesammelt hat. Bei einer 6 muss der Spieler die angezeigte Anzahl an Schlucken trinken. Bei einer 1 trinken die anderen Spieler die angezeigte Anzahl an Schlucken.
        """)
    
    
    static let twitter = Anleitung(name: "Twitter")

    // some example groups
    static let example1 = Anleitung(name: "Ich hab noch nie", items: [Anleitung.nochnieAnleitung])
    static let example2 = Anleitung(name: "Wer würde eher", items: [Anleitung.eherAnleitung])
    static let example3 = Anleitung(name: "Wahrheit oder Pflicht?", items: [ Anleitung.wahrheitPflichtAnleitung])
    static let example4 = Anleitung(name: "Höher oder Tiefer?", items: [ Anleitung.hoeherTieferAnleitung])
    static let example5 = Anleitung(name: "BANG!", items: [ Anleitung.bangAnleitung])
    static let example6 = Anleitung(name: "Captain Shithead!", items: [ Anleitung.shitheadAnleitung])
    static let example7 = Anleitung(name: "Pferderennen", items: [Anleitung.pferderennenAnleitung])
    static let example8 = Anleitung(name: "King's Cup", items: [Anleitung.kingsCupAnleitung])
    static let example9 = Anleitung(name: "Wer bin ich?", items: [ Anleitung.werbinichAnleitung])
    static let example10 = Anleitung(name: "Busfahrer", items: [ Anleitung.busfahrerAnleitung])
    static let example11 = Anleitung(name: "Mäxchen", items: [ Anleitung.maexchenAnleitung])
    static let example12 = Anleitung(name: "100", items: [ Anleitung.einhundertAnleitung])
}

struct AnleitungenView: View {
    @Environment(\.dismiss) var dismiss
    
    let items: [Anleitung] = [.example1, .example2, .example3, .example4, .example5, .example6,
                              .example7, .example8, .example9, .example10, .example11, .example12]
    
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Spacer()
                Button(action: {dismiss()}) {
                    HStack {
                        Text("Schließen")
                        Image(systemName: "x.circle")
                            .foregroundStyle(Color(UIColor.systemBlue))
                    }
                }
                .padding([.leading, .top, .trailing])
                .foregroundStyle(Color(UIColor.systemBlue))
            }
            
            List(items, children: \.items) { row in
                        Text(row.name)
                     
            }
            .accentColor(.blue)
            
//            BannerAdView()
        }
        .background(Color(UIColor.systemGray6))
        .navigationBarTitle("Anleitungen")
    }
}

struct AnleitungenView_Previews: PreviewProvider {
    static var previews: some View {
        AnleitungenView()
    }
}
