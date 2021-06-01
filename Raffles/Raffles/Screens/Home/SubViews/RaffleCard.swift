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
                    Text(raffle.name)
                        .font(.title2.bold())
                    
                    Label(
                        title: {
                            Text("Created on: \(raffle.createdDate)")
                                .fontWeight(.semibold)
                        },
                        icon: {
                            Image(systemName: "calendar")
                                .scaledToFit()
                                .frame(width: 22)
                        }
                    )
                    
                    Label(
                        title: {
                            Text("Raffled On: \(raffle.raffleDate)")
                            .fontWeight(.semibold)
                        },
                        icon: {
                            Image(systemName: "checkmark.circle.fill")
                                .scaledToFit()
                                .frame(width: 22)
                                .foregroundColor(
                                    raffle.raffledAt != nil ? .green : Color(.label)
                                )
                        }
                    )
                    
                    Label(
                        title: {
                            Text("Winner ID: \(raffle.winner)")
                                .fontWeight(.semibold)
                        },
                        icon: {
                            Image(systemName: "crown.fill")
                                .scaledToFit()
                                .frame(width: 22)
                                .foregroundColor(
                                    raffle.winnerId != nil ? .yellow : Color(.label)
                                )
                        }
                    )
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
