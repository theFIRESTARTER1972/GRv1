import Foundation

struct Product: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var quantity: Int
    var category: String
    var model: String
    var lastUpdated: Date
    
    static var sampleProducts: [Product] {
        [
            Product(name: "Sawzall", description: "Ryobi 14 inch sawzall", quantity: 5, category: "Tools", model: "1234-abcd", lastUpdated: Date()),
            Product(name: "Zero Turn Mower", description: "Badboy", quantity: 8, category: "Equipment", model: "X87", lastUpdated: Date()),
            Product(name: "Camera", description: "Nikon MS 12", quantity: 2, category: "Electronics", model: "NCP-009", lastUpdated: Date()),
            Product(name: "Industrial Bags", description: "Contractors Plus 40 mill", quantity: 53, category: "Supplies", model: "", lastUpdated: Date())
        ]
    }
}
