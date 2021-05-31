//
//  AllRafflesView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct AllRafflesView: View {
    var allRaffles: [Raffle]
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(allRaffles, id: \.id) { raffle in
                NavigationLink(
                    destination: RouterView(
                        viewModel: .init(id: raffle.id)
                    ),
                    label: {
                        RaffleCard(raffle: raffle)
                    })
                    .accentColor(Color(.label))
                    .padding(.horizontal)
            }
        }
    }
}


struct AllRafflesView_Previews: PreviewProvider {
    static let placeholders: [Raffle] = [ .placeholder ]
    
    static var previews: some View {
        Group {
            AllRafflesView(allRaffles: placeholders)
            
            AllRafflesView(allRaffles: placeholders)
                .preferredColorScheme(.dark)
        }
    }
}
