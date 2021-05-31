//
//  RouterView.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

struct RouterView: View {
    @StateObject var viewModel: RouterViewModel
    
    var body: some View {
        ZStack {
            LinearGradient.background
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack(spacing: 0) {
                        ForEach(ScreenOption.allCases, id: \.self) { option in
                            SelectionButton(option: option, currentOption: $viewModel.screenOption)
                        }
                    }
                    .padding()
                    .background(
                        NeumorphicCard()
                    )
                    .padding(.top)
                    
                    CurrentSelectionView(viewModel: viewModel)
                    
                    Spacer(minLength: 0)
                }
                .padding(.horizontal)
            } //ScrollView
        } //ZStack
        .navigationTitle(viewModel.raffle.name)
    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView(viewModel: .init(raffle: .init(id: 203, name: "Meh", createdAt: Date(), raffledAt: nil, winnerId: nil)))
    }
}

