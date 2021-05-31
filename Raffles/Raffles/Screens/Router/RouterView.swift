//
//  RouterView.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

struct RouterView: View {
    @Environment(\.presentationMode) var presentationMode
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
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .strokeBorder(style: StrokeStyle(lineWidth: 2))
                    )
                    .padding(.top)
                    
                    CurrentSelectionView(viewModel: viewModel)
                    
                    Spacer(minLength: 0)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: dismiss){
                    HStack {
                        Image(systemName: "chevron.left")
                        HStack(spacing: 2) {
                            Image(systemName: "ticket.fill")
                            Text("All Raffles")
                        }
                    }
                }
            }
        })
    }
    
    private func dismiss() {
        withAnimation {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView(viewModel: .init(raffle: .init(id: 203, name: "Meh", createdAt: Date(), raffledAt: nil, winnerId: nil)))
    }
}

