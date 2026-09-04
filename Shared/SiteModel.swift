import Foundation

final class SiteModel: ObservableObject {
    static let home = URL(string: "https://webdigistore.com/pwa/")!
    @Published var url: URL = SiteModel.home
    @Published var title = ""

    /// QR / link ile gelen davet URL'sini alır. /c/<slug> ise ilgili müşteriye gider.
    func handle(url: URL?) {
        guard let url, url.host == "webdigistore.com" else { return }
        self.url = url
    }
}
