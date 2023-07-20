//
//  ContentViewModel.swift
//  Crypto-UI
//
//  Created by Ramar Parham on 7/19/23.
//

import Foundation
import SwiftUI

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var rates = [Rate]()
        @Published var searchText = ""
        @Published var amount: Double = 100
        
        var filteredRates: [Rate] {
            return searchText == "" ? rates : rates.filter { $0.asset_id_quote.contains(searchText.uppercased()) }
        }
        
        func calcRate(rate: Rate) -> Double {
            return amount * rate.rate
        }
        
        func refreshData() {
            CryptoAPI().getCryptoData(currency: "EUR", previewMode: true) { newRates in
                DispatchQueue.main.async {
                    withAnimation {
                        self.rates = newRates
                    }
                    print("Successfully got new rates: \(self.rates.count)")
                }
            }
        }
    }
}
