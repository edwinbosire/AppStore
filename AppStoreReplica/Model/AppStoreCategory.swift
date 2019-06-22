import UIKit

struct AppStoreCategory: Codable, Hashable {
    enum Layout: String, Codable {
        case largeGallery
        case mediumGallery
        case mediumListGallery
        case header
        case footer
    }

    let identifier = UUID()
    var name: String
    var apps = [App]()
    var layout: Layout = .mediumListGallery
    
    enum CodingKeys: String, CodingKey {
        case name, apps, layout
    }

    mutating func append(_ app: App) {
        self.apps.append(app)
    }
    
    static func == (lhs: AppStoreCategory, rhs: AppStoreCategory) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

}

