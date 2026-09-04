import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var title: String
    var onFirstLoad: () -> Void = {}

    func makeCoordinator() -> Coord { Coord(self) }

    func makeUIView(context: Context) -> WKWebView {
        let cfg = WKWebViewConfiguration()
        cfg.allowsInlineMediaPlayback = true
        let wv = WKWebView(frame: .zero, configuration: cfg)
        wv.navigationDelegate = context.coordinator
        wv.allowsBackForwardNavigationGestures = true
        wv.scrollView.contentInsetAdjustmentBehavior = .never
        wv.load(URLRequest(url: url))
        return wv
    }

    func updateUIView(_ wv: WKWebView, context: Context) {
        if wv.url?.absoluteString != url.absoluteString { wv.load(URLRequest(url: url)) }
    }

    final class Coord: NSObject, WKNavigationDelegate {
        let parent: WebView
        private var loaded = false
        init(_ p: WebView) { parent = p }

        func webView(_ wv: WKWebView, didFinish _: WKNavigation!) {
            parent.title = wv.title ?? ""
            if !loaded { loaded = true; parent.onFirstLoad() }
        }

        // Dış linkler Safari'de açılsın
        func webView(_ wv: WKWebView, decidePolicyFor action: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let u = action.request.url, u.host != "webdigistore.com",
               action.navigationType == .linkActivated {
                UIApplication.shared.open(u)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
    }
}
