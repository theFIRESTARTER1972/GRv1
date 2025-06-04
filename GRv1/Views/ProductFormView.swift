import SwiftUI

struct ProductFormView: View {
    @ObservedObject var viewModel: ProductViewModel
    let product: Product?
    
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var description: String
    @State private var quantity: String
    @State private var category: String
    @State private var model: String
    
    init(viewModel: ProductViewModel, product: Product?) {
        self.viewModel = viewModel
        self.product = product
        
        _name = State(initialValue: product?.name ?? "")
        _description = State(initialValue: product?.description ?? "")
        _quantity = State(initialValue: product?.quantity.description ?? "")
        _category = State(initialValue: product?.category ?? "")
        _model = State(initialValue: product?.model ?? "")
    }
    
    var isEditing: Bool {
        product != nil
    }
    
    var body: some View {
        Form {
            Section("Product Information") {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                TextField("Category", text: $category)
                TextField("Model", text: $model)
            }
            
            Section("Inventory") {
                TextField("Quantity", text: $quantity)
                    .keyboardType(.numberPad)
            }
        }
        .navigationTitle(isEditing ? "Edit Product" : "Add Product")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveProduct()
                }
                .disabled(!isValid)
            }
        }
    }
    
    private var isValid: Bool {
        !name.isEmpty &&
        !description.isEmpty &&
        !category.isEmpty &&
        !model.isEmpty &&
        Int(quantity) != nil
    }
    
    private func saveProduct() {
        guard let quantityValue = Int(quantity) else {
            return
        }
        
        let updatedProduct = Product(
            id: product?.id ?? UUID(),
            name: name,
            description: description,
            quantity: quantityValue,
            category: category,
            model: model,
            lastUpdated: Date()
        )
        
        if isEditing {
            viewModel.updateProduct(updatedProduct)
        } else {
            viewModel.addProduct(updatedProduct)
        }
        
        dismiss()
    }
} 