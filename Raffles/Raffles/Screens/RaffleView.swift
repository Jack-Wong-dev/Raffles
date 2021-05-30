//
//  RaffleView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct RaffleView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
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
            
            Text("Register to participate in the raffle:")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("First Name ").fontWeight(.medium) + Text("*").foregroundColor(.red).fontWeight(.medium)
                TextField("First Name", text: $firstName)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Last Name ").fontWeight(.medium) + Text("*").foregroundColor(.red).fontWeight(.medium)
                TextField("Last Name", text: $lastName)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Email ").fontWeight(.medium) +
                    Text("*").foregroundColor(.red).fontWeight(.medium)
                TextField("Email", text: $email)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Phone").fontWeight(.medium)
                TextField("Phone", text: $phoneNumber)
            }
            
            Spacer(minLength: 0)
            
            HStack(spacing: 0) {
                Button(action: submit) {
                    Text("Submit")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                }
                
                Button(action: reset) {
                    Text("Reset")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private func submit() {
        withAnimation {
            
        }
    }
    
    private func reset() {
        withAnimation {
            
        }
    }
}

struct RaffleView_Previews: PreviewProvider {
    static var previews: some View {
        RaffleView()
    }
}
