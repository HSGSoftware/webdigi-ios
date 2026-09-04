import SwiftUI
import StoreKit

@main
struct ClipApp: App {
    @StateObject private var model = SiteModel()
    @State private var offerFullApp = false

    var body: some Scene {
        WindowGroup {
            WebView(url: model.url, title: $model.title) {
                // İlk yüklemeden 20 sn sonra tam uygulamayı öner
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) { offerFullApp = true }
            }
            .ignoresSafeArea()
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { model.handle(url: $0.webpageURL) }
            .appStoreOverlay(isPresented: $offerFullApp) {
                SKOverlay.AppClipConfiguration(position: .bottom)
            }
        }
    }
}
