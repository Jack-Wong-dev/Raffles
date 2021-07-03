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
            ForEach(viewModel.filteredRaffles, id: \.id, content: RaffleRow.init)
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

struct RaffleRow: View {
    let raffle: Raffle
    
    var body: some View {
        NavigationLink(
            destination: RouterView(
                viewModel: .init(raffle: raffle)
            ),
            label: {
            RaffleCard(raffle: raffle)
        })
            .accentColor(Color(.label))
            .padding(.horizontal)
    }
}
