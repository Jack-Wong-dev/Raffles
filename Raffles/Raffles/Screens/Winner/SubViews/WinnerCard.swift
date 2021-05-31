//
//  WinnerCard.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

struct WinnerCard: View {
    let winner: PickWinnerResponse
    
    var body: some View {
        VStack {
            Color.red
                .scaledToFit()
                .cornerRadius(8)
            
            Group {
                Text(winner.fullName)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Text("Registered on \(winner.registeredAt)")
                    .foregroundColor(Color(.secondaryLabel))
                
                VStack(alignment: .leading) {
                    Group {
                        Label("\(winner.id)", systemImage: "number")
                        Label(winner.email, systemImage: "envelope.fill")
                        Label(winner.phone ?? "N/A", systemImage: "phone")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(NeumorphicCard())
    }
}


struct WinnerCard_Previews: PreviewProvider {
    static var previews: some View {
        WinnerCard(winner: .placeholder)
    }
}
