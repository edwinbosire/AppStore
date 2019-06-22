import Foundation
import SwiftUI

struct App: Codable, Hashable, Identifiable {
    var id = UUID()
    var name: String = ""
    var category: String = ""
    var imageName: String = ""
    var price: Double = 0.0
    
    var screenshots: [String]?
    var desc: String?
    var appInformation: String?
    var note: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case category = "Category"
        case imageName = "ImageName"
        case price = "Price"
        case desc
        case note
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
