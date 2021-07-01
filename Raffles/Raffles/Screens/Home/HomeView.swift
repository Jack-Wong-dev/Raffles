//
//  HomeView.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .init()
    @State private var yContentOffset: CGFloat = .zero
    
    var body: some View {
        NavigationView {
            //Making the whole screen scrollable will ensure the device can be used in landscape mode
            ScrollViewReader { scrollProxy in
                ZStack(alignment: .topTrailing) {
                    LinearGradient.background
                        .ignoresSafeArea()
                    
                    TrackableScrollView { offset in
                        yContentOffset = offset.y
                    } content: {
                        VStack(alignment: .leading, spacing: 20) {
                            CreateRaffleView()

                            Text("All Raffles:").font(.title2.bold()).padding(.leading)

                            //MARK: Raffles List
                            AllRafflesView(viewModel: viewModel)
                                .redacted(reason: viewModel.isLoading ? .placeholder : .init())
                                .disabled(viewModel.isLoading)

                            Spacer(minLength: 0)
                                .id("bottom")
                        }
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    }
                    .refreshable {
                        print("refreshing")
                    }

                    
//                    ScrollView(showsIndicators: true) {
//                        VStack(alignment: .leading, spacing: 20) {
//                            CreateRaffleView()
//
//                            Text("All Raffles:").font(.title2.bold()).padding(.leading)
//
//                            //MARK: Raffles List
//                            AllRafflesView(viewModel: viewModel)
//                                .redacted(reason: viewModel.isLoading ? .placeholder : .init())
//                                .disabled(viewModel.isLoading)
//
//                            Spacer(minLength: 0)
//                        }
//                        .autocapitalization(.none)
//                        .disableAutocorrection(true)
//                    }
                    //MARK: Scroll To Top Button
                    VStack {
                        Button(action: { scrollToTop(proxy: scrollProxy) }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32)
                                .shadow(color: .shadow, radius: 15, x: 15, y: 15)
                        }
                        
                        Button(action: { scrollToBottom(proxy: scrollProxy) }) {
                            Image(systemName: "arrow.down.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32)
                                .shadow(color: .shadow, radius: 15, x: 15, y: 15)
                        }
                    }
                    .opacity(yContentOffset < -10 ? 1 : 0)
                    .padding(.horizontal)
                } //ZStack
            } //ScrollViewReader
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
            } // Alert
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .onAppear(perform: viewModel.getRaffles)
        } // Navigation View
        .environmentObject(viewModel)
        .accentColor(.purple)
    }
        
    //MARK: Private methods
    private func scrollToTop(proxy: ScrollViewProxy) {
        withAnimation {
            proxy.scrollTo("top", anchor: .top)
        }
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        withAnimation {
            proxy.scrollTo("bottom", anchor: .bottom)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
