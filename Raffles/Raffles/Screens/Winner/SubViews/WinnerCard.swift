//
//  WinnerCard.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

struct WinnerCard: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    let winner: PickWinnerResponse
    
    var body: some View {
        ZStack(alignment: .top) {
            switch (horizontalSizeClass, verticalSizeClass) {
            //e.g iPhones in Portrait, some iPads in split screen
            case (.compact, .regular):
                VStack {
                    content
                }
            default:
                HStack {
                    content
                }
            }
        }
        .padding()
        .background(NeumorphicCard())
    }
    
    var content: some View {
        Group {
            Color.red
                .scaledToFit()
                .cornerRadius(8)
            
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    Text(winner.fullName)
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Text("Registered on \(winner.registeredAt)")
                        .foregroundColor(Color(.secondaryLabel))
                
                    Label("\(winner.id)", systemImage: "number")
                    Label(winner.email, systemImage: "envelope.fill")
                    Label(winner.phone ?? "N/A", systemImage: "phone")
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }
}


struct WinnerCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WinnerCard(winner: .placeholder)
            WinnerCard(winner: .placeholder)
        }
    }
}
