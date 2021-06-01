//
//  AppTitle.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

struct AppTitle: View {
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            Text("Raffle App")
                .font(.largeTitle.weight(.heavy))
                
                .opacity(0)
                .overlay(
                    LinearGradient(gradient: .init(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing)
                        .mask(
                            Text("Raffle App")
                                .font(.largeTitle.weight(.heavy))
                        )
                )
            Spacer(minLength: 0)
        }
    }
}


struct AppTitle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppTitle()
            
            AppTitle()
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
