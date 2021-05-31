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
        NavigationView {
            //Making the whole screen scrollable will ensure the device can be used in landscape mode
            ScrollViewReader { scrollProxy in
                ZStack(alignment: .topTrailing) {
                    LinearGradient.background
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            Group {
                                Text("Raffle App")
                                    .font(.largeTitle.bold())
                                    .frame(maxWidth: .infinity)
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
                                                .fill(Color.blue)
                                        )
                                        .shadow(color: .shadow, radius: 15, x: 15, y: 15)
                                }
                                .accentColor(.white)
                            }
                            .padding(.horizontal)
                            
                            Text("All Raffles:").font(.title2.bold()).padding(.leading)
                            
                            AllRafflesView(viewModel: viewModel)
                            
                            Spacer(minLength: 0)
                        }
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    }
                    
                    Button(action: { scrollToTop(proxy: scrollProxy) }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32)
                            .shadow(color: .shadow, radius: 15, x: 15, y: 15)
                    }
                    .padding(.horizontal)
                }
            }//ZStack
            .alert(item: $viewModel.alertMessage) { message in
                switch message {
                case .success(let title, let content):
                    return Alert(
                        title: Text(title),
                        message: Text(content),
                        dismissButton: .default(Text("Okay"), action: viewModel.resetFields)
                    )
                case .failure(let errorMessage):
                    return Alert(title: Text(errorMessage))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        } // Navigation View
        .environmentObject(viewModel)
    }
    
    private func createNewRaffle() {
        withAnimation {
            viewModel.createRaffle()
        }
    }
    
    private func scrollToTop(proxy: ScrollViewProxy) {
        withAnimation {
            proxy.scrollTo("top", anchor: .top)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
