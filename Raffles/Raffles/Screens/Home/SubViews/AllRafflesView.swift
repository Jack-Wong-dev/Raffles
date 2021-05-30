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
        LazyVStack {
            ForEach(allRaffles, id: \.id, content: RaffleCard.init)
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
