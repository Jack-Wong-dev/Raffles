//
//  WinnerView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct ShowWinnerView: View {
    @StateObject var viewModel: WinnerViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Raffle App")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity)
            
            Text("Sample Raffle")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity)
            
            HStack(spacing: 0) {
                Group {
                    VStack {
                        Image(systemName: "ticket.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 22)
                        Text("All Raffles")
                    }
                    
                    VStack {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 22)
                        Text("Register")
                    }
                    
                    VStack {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 22)
                        Text("Participants")
                            .lineLimit(1)
                    }
                    
                    VStack {
                        Image(systemName: "crown.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 22)
                        Text("Winner")
                            .lineLimit(1)
                    }
                }
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2))
            )
            
            Text("Winner")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let winner = viewModel.winner {
                WinnerCard(winner: winner)
            }
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        ShowWinnerView(viewModel: .init(id: 203))
    }
}

struct WinnerCard: View {
    let winner: PickWinnerResponse
    
    var body: some View {
        VStack {
            Color.red
                .scaledToFit()
            
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
    }
}
