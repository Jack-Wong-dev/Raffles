//
//  RoundedCorner.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
struct RoundedCorner_Previews: PreviewProvider {
    static var previews: some View {
        RoundedCorner(radius: 20, corners: [.topLeft, .bottomLeft])
            .frame(width: 200, height: 100)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
