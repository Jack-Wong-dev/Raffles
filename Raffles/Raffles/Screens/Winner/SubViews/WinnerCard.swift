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
            Color.clear
                .scaledToFit()
                .overlay(
                    Image("trophy")
                        .renderingMode(.original)
                        .scaledToFit()
                )
            
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    Text(winner.fullName)
                        .font(.title2)
                        .fontWeight(.medium)
                
                    Label(
                        title: {
                            Text("\(winner.id)")
                                .fontWeight(.semibold)
                        },
                        icon: {
                            Image(systemName: "number")
                                .scaledToFit()
                                .frame(width: 22)
                        }
                    )
                    
                    Label(
                        title: {
                            Text("\(winner.email)")
                                .fontWeight(.semibold)
                        },
                        icon: {
                            Image(systemName: "envelope.fill")
                                .scaledToFit()
                                .frame(width: 22)
                        }
                    )
                    
                    Label(
                        title: {
                            Text("\(winner.phone ?? "")")
                                .fontWeight(.semibold)
                        },
                        icon: {
                            Image(systemName: "phone")
                                .scaledToFit()
                                .frame(width: 22)
                        }
                    )
                    
                    Text("Registered on \(winner.registerdDate)")
                        .font(.caption.weight(.medium))
                        .foregroundColor(Color(.secondaryLabel))
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
