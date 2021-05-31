//
//  CurrentSelectionView.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

struct CurrentSelectionView: View {
    @ObservedObject var viewModel: RouterViewModel
    
    var body: some View {
        Group {
            switch viewModel.screenOption {
            case .register:
                RegisterView(
                    viewModel: .init(id: viewModel.raffle.id)
                )
                .transition(.scale.combined(with: .opacity))
            case .participants:
                RaffleParticipantsView(
                    viewModel: .init(id: viewModel.raffle.id)
                )
                .transition(.scale.combined(with: .opacity))
            case .winner:
                WinnerView(viewModel: .init(raffle: viewModel.raffle))
                .transition(.scale.combined(with: .opacity))
            }
        }
    }
}


struct CurrentSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentSelectionView(viewModel: .init(raffle: .placeholder))
    }
}
