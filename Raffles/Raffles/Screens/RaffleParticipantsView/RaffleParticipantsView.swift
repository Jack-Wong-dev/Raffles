//
//  RaffleParticipantsView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct RaffleParticipantsView: View {
    @StateObject var viewModel: ParticipantsViewModel
    
    var body: some View {
        VStack(spacing: 20) {
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
                        Text("Pick Winner")
                            .lineLimit(2)
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
            
            Text("Participants: \(viewModel.allParticipants.count) total")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(showsIndicators: false) {
                ParticipantsView(participants: viewModel.allParticipants)
            }
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
}

struct RaffleParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        RaffleParticipantsView(viewModel: .init(id: 8))
    }
}

struct ParticipantsView: View {
    var participants: [Participant]
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(participants, id: \.id, content: ParticipantCell.init)
        }
    }
}

struct ParticipantCell: View {
    let participant: Participant
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(participant.fullName)
                .fontWeight(.medium)
            
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                VStack(alignment: .leading) {
                    Group {
                        Label("\(participant.id)", systemImage: "number")
                        Label(participant.email, systemImage: "envelope.fill")
                        Label(participant.phone ?? "N/A", systemImage: "phone")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .strokeBorder(style: StrokeStyle(lineWidth: 2))
        )
    }
}
