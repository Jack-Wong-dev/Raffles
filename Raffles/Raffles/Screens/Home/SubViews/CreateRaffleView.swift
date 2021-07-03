//
//  CreateRaffleView.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

enum CreateRaffleFocus {
    case name
    case secretToken
}

struct CreateRaffleView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @FocusState var focus: CreateRaffleFocus?
    
    var body: some View {
        VStack {
            AppTitle()
                .id("top")
                
            Text("New Raffle:")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Raffle Name ")
                    .fontWeight(.medium)
                    + Text("*").foregroundColor(.red).fontWeight(.medium)
                TextField("", text: $viewModel.raffleName)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Raffle Secret Token ")
                    .fontWeight(.medium)
                    + Text("*").foregroundColor(.red).fontWeight(.medium)
                TextField("", text: $viewModel.secretToken)
            }
            
            Text("You must remember the Raffle Token because it will be asked when picking a winner")
            
            Button(action: createNewRaffle) {
                Text("Create New Raffle")
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(LinearGradient(gradient: .init(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing))
                            .shadow(color: .shadow, radius: 15, x: 15, y: 15)
                    )
            }
            .accentColor(.white)
            .opacity(viewModel.buttonDisabled ? 0.5 : 1)
            .disabled(viewModel.buttonDisabled)
        } // Group
        .padding(.horizontal)
    }
    
    private func createNewRaffle() {
        withAnimation {
            viewModel.createRaffle()
        }
    }
}

struct CreateRaffleView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRaffleView()
            .environmentObject(HomeViewModel())
    }
}
