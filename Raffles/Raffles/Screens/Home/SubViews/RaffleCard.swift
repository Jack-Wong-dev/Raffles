//
//  RaffleCard.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct RaffleCard: View {
    let raffle: Raffle
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    Text("\(raffle.name)'s raffle")
                        .font(.title2.bold())
                    
                    Text("Created on: \(raffle.createdDate)")
                        .fontWeight(.semibold)
                    
                    Text("Raffled On: \(raffle.raffleDate)")
                        .fontWeight(.semibold)
                    
                    Text("\(Image(systemName: "crown.fill")) ")
                        .foregroundColor(raffle.winnerId != nil ? .yellow : Color(.label))
                        .font(.callout.weight(.semibold))
                    + Text("Winner ID: ")
                        .font(.callout.weight(.semibold))
                    + Text("\(raffle.winner)")
                        .fontWeight(.heavy)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                NeumorphicCard()
            )
        }
    }
}


struct RaffleCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RaffleCard(raffle: .placeholder)
            
            RaffleCard(raffle: .placeholder)
                .preferredColorScheme(.dark)
        }
        .padding()
    }
}
