//
//  RaffleView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct RaffleView: View {
    @StateObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Register to participate in the raffle:")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            //MARK: Textfields
            VStack(alignment: .leading, spacing: 4) {
                Text("First Name ").fontWeight(.medium) + Text("*").foregroundColor(.red).fontWeight(.medium)
                TextField("First Name", text: $viewModel.firstName)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Last Name ").fontWeight(.medium) + Text("*").foregroundColor(.red).fontWeight(.medium)
                TextField("Last Name", text: $viewModel.lastName)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Email ").fontWeight(.medium) +
                    Text("*").foregroundColor(.red).fontWeight(.medium)
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Phone").fontWeight(.medium)
                TextField("Phone", text: $viewModel.phoneNumber)
            }
            
            Spacer(minLength: 0)
            
            //MARK: Buttons
            HStack(spacing: 0) {
                Button(action: submit) {
                    Text("Submit")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedCorner(radius: 16,
                                          corners: [.topLeft,.bottomLeft])
                        )
                }
                
                Button(action: reset) {
                    Text("Reset")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedCorner(radius: 16,
                                          corners: [.topRight,.bottomRight]
                            )
                            .fill(Color.red)
                        )
                }
            } // HStack
            .padding(.horizontal)
        } // VStack
        
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
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    //MARK: Private Methods
    private func submit() {
        withAnimation {
            viewModel.register()
        }
    }
    
    private func reset() {
        withAnimation {
            viewModel.reset()
        }
    }
}

struct RaffleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RaffleView(viewModel: .init(id: 203))
                .preferredColorScheme(.dark)
            
            RaffleView(viewModel: .init(id: 203))
        }
    }
}
