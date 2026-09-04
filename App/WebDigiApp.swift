import SwiftUI

@main
struct WebDigiApp: App {
    @StateObject private var model = SiteModel()

    var body: some Scene {
        WindowGroup {
            WebView(url: model.url, title: $model.title)
                .ignoresSafeArea()
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { model.handle(url: $0.webpageURL) }
                .onOpenURL { model.handle(url: $0) }
        }
    }
}
