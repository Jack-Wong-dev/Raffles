//
//  RouterView.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

enum RaffleScreen {
    case register
    case participants
    case winner
}

final class RouterViewModel: ObservableObject {
    let id: Int
    
    @Published var screen: RaffleScreen
    
    init(id: Int, screen: RaffleScreen = .participants) {
        self.id = id
        self.screen = screen
    }
}

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
                    
                    switch viewModel.screen {
                    case .register:
                        RaffleView(
                            viewModel: .init(id: viewModel.id)
                        )
                    case .participants:
                        RaffleParticipantsView(
                            viewModel: .init(id: viewModel.id)
                        )
                    case .winner:
                        PickAWinnerView(
                            viewModel: .init(id: viewModel.id)
                        )
                    }
                    
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
        RouterView(viewModel: .init(id: 203))
    }
}
