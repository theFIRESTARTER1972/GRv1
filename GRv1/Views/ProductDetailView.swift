import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @ObservedObject var viewModel: ProductViewModel
    @State private var showingEditSheet = false
    @State private var showingDeleteAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text(product.name)
                        .font(.title)
                        .bold()
                    
                    Text(product.description)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text("Category:")
                            .foregroundColor(.secondary)
                        Text(product.category)
                    }
                    
                    HStack {
                        Text("Model:")
                            .foregroundColor(.secondary)
                        Text(product.model)
                    }
                }
                .padding(.vertical, 8)
            }
            
            Section("Inventory") {
                HStack {
                    Text("Quantity")
                    Spacer()
                    Text("\(product.quantity)")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Last Updated")
                    Spacer()
                    Text(product.lastUpdated.formatted(date: .abbreviated, time: .shortened))
                        .foregroundColor(.secondary)
                }
            }
            
            Section {
                Button(role: .destructive) {
                    showingDeleteAlert = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Delete Product")
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEditSheet = true
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            NavigationStack {
                ProductFormView(viewModel: viewModel, product: product)
            }
        }
        .alert("Delete Product", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteProduct(product)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete '\(product.name)'? This action cannot be undone.")
        }
    }
} 
