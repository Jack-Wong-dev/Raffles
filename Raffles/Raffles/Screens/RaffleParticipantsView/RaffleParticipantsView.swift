//
//  RaffleParticipantsView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct RaffleParticipantsView: View {
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
            
            Text("Participants: 6 total")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(0..<6, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text("Alejandro Franco")
                                .fontWeight(.medium)
                            
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 50)
                                VStack(alignment: .leading) {
                                    Group {
                                        Label("1", systemImage: "number")
                                        Label("alejandrofranco@pursuit.org", systemImage: "envelope.fill")
                                        Label("12345678900", systemImage: "phone")
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
            }
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
}

struct RaffleParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        RaffleParticipantsView()
    }
}
