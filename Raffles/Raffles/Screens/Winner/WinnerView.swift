//
//  WinnerView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct WinnerView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel: WinnerViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Winner")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                        
            if let winner = viewModel.winner {
                WinnerCard(winner: winner)
                    .transition(.scale.combined(with: .opacity))
            } else {
                PickAWinnerView(viewModel: .init(raffle: viewModel.raffle)) { winner in
                    withAnimation {
                        viewModel.winner = winner
                    }
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(viewModel: .init(raffle: .placeholder))
            .environmentObject(HomeViewModel())
    }
}
