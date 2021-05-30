//
//  HomeView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct HomeView: View {
    @State private var raffleName: String = ""
    @State private var secretToken: String = ""
    
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
                    TextField("", text: $raffleName)
                }
                VStack(spacing: 4) {
                    Text("Raffle Secret Token*")
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $secretToken)
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
                ForEach(0..<4, id: \.self) { _ in
                    LazyVStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Jovanny's raffle").font(.title3).fontWeight(.medium)
                            Text("Created on: May 22 2021 at 8:02:46 PM")
                            Text("Winner ID: 11")
                            Text("Raffled On: Sat May 22 2021 at 8:05:58 PM")
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                                .strokeBorder(style: StrokeStyle(lineWidth: 2))
                        )
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer(minLength: 0)
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private func createNewRaffle() {
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
