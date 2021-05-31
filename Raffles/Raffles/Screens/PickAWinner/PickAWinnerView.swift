//
//  PickAWinnerView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct PickAWinnerView: View {
    @StateObject var viewModel: PickAWinnerViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Raffle App")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity)
                
                Text("Sample Raffle")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity)
                
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
                
                Text("Pick a Winner")
                    .font(.title.bold())
                
                TextField("Secret Token", text: $viewModel.secretToken)
                    .autocapitalization(.none)
                
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
                }
                
                VStack(alignment: .leading) {
                    Text("Secret Token")
                    Text("The secret token used when creating the raffle must be provided.")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                        .strokeBorder(style: StrokeStyle(lineWidth: 1))
                )
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .alert(item: $viewModel.alertMessage) { message in
            switch message {
            case .success(let title, let content):
                return Alert(
                    title: Text(title),
                    message: Text(content),
                    dismissButton: .default(Text("Okay"), action: viewModel.reset)
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
            PickAWinnerView(viewModel: .init(id: 211))
            
            PickAWinnerView(viewModel: .init(id: 211))
                .preferredColorScheme(.dark)
        }
    }
}
