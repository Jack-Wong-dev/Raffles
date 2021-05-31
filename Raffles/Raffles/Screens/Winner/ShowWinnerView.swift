//
//  WinnerView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct ShowWinnerView: View {
    @StateObject var viewModel: WinnerViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Winner")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                        
            if let winner = viewModel.winner {
                WinnerCard(winner: winner)
            } else {
                PickAWinnerView(viewModel: .init(raffle: viewModel.raffle))
            }
        }
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        ShowWinnerView(viewModel: .init(raffle: .placeholder))
    }
}

struct WinnerCard: View {
    let winner: PickWinnerResponse
    
    var body: some View {
        VStack {
            Color.red
                .scaledToFit()
            
            Group {
                Text(winner.fullName)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Text("Registered on \(winner.registeredAt)")
                    .foregroundColor(Color(.secondaryLabel))
                
                VStack(alignment: .leading) {
                    Group {
                        Label("\(winner.id)", systemImage: "number")
                        Label(winner.email, systemImage: "envelope.fill")
                        Label(winner.phone ?? "N/A", systemImage: "phone")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
