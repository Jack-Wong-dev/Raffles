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
                    Text("\(raffle.name)'s raffle").font(.title3).fontWeight(.medium)
                    Text("Created on: \(raffle.createdAt)")
                    Text("Winner ID: \(raffle.winner)")
                    Text("Raffled On: \(raffle.raffleDate)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                    
                    RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                        .strokeBorder(style: StrokeStyle(lineWidth: 2))
                }
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
