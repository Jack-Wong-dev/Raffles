//
//  AppTitle.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

struct AppTitle: View {
    var body: some View {
        Text("Raffle App")
            .font(.largeTitle.weight(.heavy))
            .foregroundStyle(.linearGradient(.init(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing))
            .frame(maxWidth: .infinity, alignment: .center)
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
