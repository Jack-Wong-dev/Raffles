//
//  AllRafflesView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct AllRafflesView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 25) {
            ForEach(viewModel.allRaffles, id: \.id) { raffle in
                NavigationLink(
                    destination: RouterView(
                        viewModel: .init(raffle: raffle)
                    ),
//                    tag: raffle.id,
//                    selection: $viewModel.currentRaffleId,
                    label: {RaffleCard(raffle: raffle)})
                    .accentColor(Color(.label))
                    .padding(.horizontal)
//                    .disabled(viewModel.currentRaffleId == raffle.id)
            }
        }
    }
}


struct AllRafflesView_Previews: PreviewProvider {
    static let placeholders: [Raffle] = [ .placeholder ]
    
    static var previews: some View {
        Group {
            AllRafflesView(viewModel: .init())
            
            AllRafflesView(viewModel: .init())
                .preferredColorScheme(.dark)
        }
    }
}
