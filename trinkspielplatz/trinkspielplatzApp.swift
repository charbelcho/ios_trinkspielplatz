//
//  trinkspielplatzApp.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 21.12.21.
//

import SwiftUI
import GoogleMobileAds

@main
struct trinkspielplatzApp: App {
    init(){
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        // Google Analytics initiliaze here
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
