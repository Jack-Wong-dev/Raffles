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
            Text("Participants: \(viewModel.allParticipants.count) total")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ParticipantsView(participants: viewModel.allParticipants)
        }
    }
}

struct RaffleParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        RaffleParticipantsView(viewModel: .init(id: 8))
    }
}

