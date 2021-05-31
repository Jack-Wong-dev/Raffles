//
//  RouterView.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

enum RaffleScreen: String, CaseIterable {
    case register = "register"
    case participants = "participants"
    case winner = "winner"
}

extension RaffleScreen {
    var systemName: String {
        switch self {
        case .register:
            return "square.and.pencil"
        case .participants:
            return "person.3.fill"
        case .winner:
            return "crown.fill"
        }
    }
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
                        ForEach(RaffleScreen.allCases, id: \.self) { choice in
                            SegmentedButton(screen: choice, currentScreen: $viewModel.screen)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .strokeBorder(style: StrokeStyle(lineWidth: 2))
                    )
                    
                    switch viewModel.screen {
                    case .register:
                        RegisterView(
                            viewModel: .init(id: viewModel.id)
                        )
                        .transition(.scale.combined(with: .opacity))
                    case .participants:
                        RaffleParticipantsView(
                            viewModel: .init(id: viewModel.id)
                        )
                        .transition(.scale.combined(with: .opacity))
                    case .winner:
                        PickAWinnerView(
                            viewModel: .init(id: viewModel.id)
                        )
                        .transition(.scale.combined(with: .opacity))
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

struct SegmentedButton: View {
    let screen: RaffleScreen
    @Binding var currentScreen: RaffleScreen
    
    var color: Color {
        screen == currentScreen ? .getSelectionColor(using: screen) : .secondary
    }
    
    var body: some View {
        Button(action: goToScreen) {
            VStack {
                Image(systemName: screen.systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 22)
                Text(screen.rawValue.capitalized)
            }
            .foregroundColor(color)
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
        }
    }
    
    private func goToScreen() {
        withAnimation {
            currentScreen = screen
        }
    }
}