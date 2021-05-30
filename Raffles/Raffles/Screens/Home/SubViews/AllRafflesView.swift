//
//  AllRafflesView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct AllRafflesView: View {
    @Binding var allRaffles: [Raffle]
    
    var body: some View {
        LazyVStack {
            ForEach(0..<4, id: \.self) { _ in
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Jovanny's raffle").font(.title3).fontWeight(.medium)
                        Text("Created on: May 22 2021 at 8:02:46 PM")
                        Text("Winner ID: 11")
                        Text("Raffled On: Sat May 22 2021 at 8:05:58 PM")
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                            .strokeBorder(style: StrokeStyle(lineWidth: 2))
                    )
                }
            }
        }
    }
}


struct AllRafflesView_Previews: PreviewProvider {
    static let placeholders: [Raffle] = Array(repeating: .placeholder, count: 5)
    
    static var previews: some View {
        Group {
            AllRafflesView(allRaffles: .constant(placeholders))
            
            AllRafflesView(allRaffles: .constant(placeholders))
                .preferredColorScheme(.dark)
        }
    }
}
