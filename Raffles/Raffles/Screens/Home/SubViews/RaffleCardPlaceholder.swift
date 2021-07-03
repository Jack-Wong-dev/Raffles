//
//  RaffleCardPlaceholder.swift
//  Raffles
//
//  Created by Jack Wong on 7/3/21.
//

import SwiftUI

struct RaffleCardPlaceholder: View {
    @State private var condition: Bool = false

    let raffle: Raffle = .placeholder

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
                        }
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .redacted(reason: .placeholder)
                .opacity(condition ? 1.0 : 0.0)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                NeumorphicCard()
            )
            .onAppear(perform: onAppear)
        }
    }
    
    private func onAppear() {
        withAnimation(Animation.easeIn(duration: 1).repeatForever(autoreverses: true)) {
            condition = true
        }
    }
}

struct RaffleCardPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RaffleCardPlaceholder()
                .padding()
            .previewLayout(.sizeThatFits)
        }
    }
}
