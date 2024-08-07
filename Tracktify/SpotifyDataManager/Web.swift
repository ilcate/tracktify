import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            guard let urlString = webView.url?.absoluteString else { return }
            var tokenString = ""
            if urlString.contains("#access_token=") {
                let range = urlString.range(of: "#access_token=")
                guard let index = range?.upperBound else { return }
                tokenString = String(urlString[index...])
            }

            if !tokenString.isEmpty {
                let range = tokenString.range(of: "&token_type=Bearer")
                guard let index = range?.lowerBound else { return }
                tokenString = String(tokenString[..<index])
                UserDefaults.standard.setValue(tokenString, forKey: "Authorization")
                parent.didFinishLoading(tokenString)
            }
        }
    }

    var urlRequest: URLRequest
    var didFinishLoading: (String) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(urlRequest)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
