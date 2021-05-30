//
//  HomeView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .init()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Group {
                Text("Raffle App")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity)
                
                Text("New Raffle:")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 4) {
                    Text("Raffle Name")
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $viewModel.raffleName)
                }
                VStack(spacing: 4) {
                    Text("Raffle Secret Token*")
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
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
                                .fill(Color.blue)
                        )
                }
                .accentColor(.white)
            }
            .padding(.horizontal)
            
            Text("All Raffles:").font(.title2.bold()).padding(.leading)
            
            ScrollView(showsIndicators: false) {
                AllRafflesView(allRaffles: viewModel.allRaffles)
            }
            
            Spacer(minLength: 0)
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .alert(item: $viewModel.alertMessage) { message in
            switch message {
            case .success(let successMessage):
                return Alert(
                    title: Text("Success"),
                    message: Text(successMessage),
                    dismissButton: .default(Text("Okay"), action: viewModel.resetFields)
                )
            case .failure(let errorMessage):
                return Alert(title: Text(errorMessage))
            }
        }
    }
    
    private func createNewRaffle() {
        withAnimation {
            viewModel.createRaffle()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
