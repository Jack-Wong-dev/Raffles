//
//  PickAWinnerView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct PickAWinnerView: View {
    @StateObject var viewModel: PickAWinnerViewModel
    let completion: (PickWinnerResponse?) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Pick a Winner")
                .font(.title.bold())
            
            TextField("Secret Token", text: $viewModel.secretToken)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            VStack(alignment: .leading) {
                Group {
                    Text("Secret Token")
                    Text("The secret token used when creating the raffle must be provided.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1))
            )
            
            Spacer(minLength: 0)
            
            Button(action: pickAWinner) {
                Text("Pick a Winner")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.blue)
                    )
                    .shadow(color: .shadow, radius: 15, x: 15, y: 15)
            }
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .alert(item: $viewModel.alertMessage) { message in
            switch message {
            case .success(let title, let content):
                return Alert(
                    title: Text(title),
                    message: Text(content),
                    dismissButton: .default(Text("Okay")) {
                        if let winner = viewModel.winner {
                            completion(winner)
                        }
                    }
                )
            case .failure(let errorMessage):
                return Alert(title: Text(errorMessage))
            }
        }
    }
    
    private func pickAWinner() {
        withAnimation {
            viewModel.pickWinner()
        }
    }
}

struct PickAWinnerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PickAWinnerView(viewModel: .init(raffle: .placeholder)) { winner in
                
            }
            
            PickAWinnerView(viewModel: .init(raffle: .placeholder)) { winner in 
                
            }
                .preferredColorScheme(.dark)
        }
    }
}
