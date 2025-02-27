//
//  ContentView.swift
//  WebView-SwiftUI
//
//  Created by Fatih Kenarda on 12.02.2025.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var isLoading: Bool = false
    @StateObject private var viewModel = WebViewModel()
    let url = URL(string: "https://www.apple.com")!

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if viewModel.canGoBack {
                        viewModel.goBack()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                }
                .disabled(!viewModel.canGoBack)

                Spacer()

                Button(action: {
                    if viewModel.canGoForward {
                        viewModel.goForward()
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title)
                }
                .disabled(!viewModel.canGoForward)
            }
            .padding()
            
            // ProgressView (Yükleniyor göstergesi)
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }

            WebView(url: url, viewModel: viewModel, isLoading: $isLoading)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle("Web Tarayıcı")
    }
}


#Preview {
    ContentView()
}
