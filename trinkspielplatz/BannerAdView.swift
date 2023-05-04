//
//  BannerAdView.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 04.05.23.
//

import SwiftUI

struct BannerAdView: View {
    var body: some View {
        BannerAd(unitID: "ca-app-pub-3940256099942544/2934735716")
            .frame(height: 100)
    }
}

struct BannerAdView_Previews: PreviewProvider {
    static var previews: some View {
        BannerAdView()
    }
}
