//
//  WebView.swift
//  WebView-SwiftUI
//
//  Created by Fatih Kenarda on 12.02.2025.
//

import SwiftUI
import WebKit

// WebView için bir ViewModel (Geri-İleri butonlarını yönetmek için)
class WebViewModel: ObservableObject {
    @Published var webView = WKWebView()

    var canGoBack: Bool {
        webView.canGoBack
    }
    
    var canGoForward: Bool {
        webView.canGoForward
    }

    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

// WebView Bileşeni
struct WebView: UIViewRepresentable {
    let url: URL
    @ObservedObject var viewModel: WebViewModel
    @Binding var isLoading: Bool

    func makeUIView(context: Context) -> WKWebView {
        let webView = viewModel.webView
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
    }
}
