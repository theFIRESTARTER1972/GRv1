import Foundation
import SwiftUI

@MainActor
class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchText = ""
    @Published var selectedCategory: String?
    
    var filteredProducts: [Product] {
        products.filter { product in
            let matchesSearch = searchText.isEmpty || 
                product.name.localizedCaseInsensitiveContains(searchText) ||
                product.description.localizedCaseInsensitiveContains(searchText)
            
            let matchesCategory = selectedCategory == nil || product.category == selectedCategory
            
            return matchesSearch && matchesCategory
        }
    }
    
    var categories: [String] {
        Array(Set(products.map { $0.category })).sorted()
    }
    
    init() {
        // Load sample data for now
        products = Product.sampleProducts
    }
    
    func addProduct(_ product: Product) {
        products.append(product)
    }
    
    func updateProduct(_ product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index] = product
        }
    }
    
    func deleteProduct(_ product: Product) {
        products.removeAll { $0.id == product.id }
    }
} 