//
//  ParticipantsView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct ParticipantsView: View {
    var participants: [Participant]
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(participants, id: \.id, content: ParticipantCell.init)
        }
    }
}


struct ParticipantsView_Previews: PreviewProvider {
    static let placeholder: [Participant] = [ .placeholder ]
    static var previews: some View {
        Group {
            ParticipantsView(participants: placeholder)
            ParticipantsView(participants: placeholder)
                .preferredColorScheme(.dark)
        }
        .padding(.horizontal)
    }
}
