import SwiftUI

struct ProductListView: View {
    @Binding var showLanding: Bool
    @StateObject private var viewModel = ProductViewModel()
    @State private var showingAddProduct = false
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.green.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            NavigationStack {
                VStack {
                    // Category filter
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            CategoryButton(title: "All", isSelected: viewModel.selectedCategory == nil) {
                                viewModel.selectedCategory = nil
                            }
                            
                            ForEach(viewModel.categories, id: \.self) { category in
                                CategoryButton(title: category, isSelected: viewModel.selectedCategory == category) {
                                    viewModel.selectedCategory = category
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .shadow(radius: 6)
                        .padding(.top, 8)
                    }
                    
                    List {
                        ForEach(viewModel.filteredProducts) { product in
                            NavigationLink(destination: ProductDetailView(product: product, viewModel: viewModel)) {
                                ProductCardView(product: product)
                            }
                            .listRowBackground(Color.clear)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                viewModel.deleteProduct(viewModel.filteredProducts[index])
                            }
                        }
                    }
                    .listStyle(.plain)
                    .background(Color.clear)
                }
                .searchable(text: $viewModel.searchText, prompt: "Search products")
                .navigationTitle("Inventory")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { showLanding = true }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                        .accessibilityLabel("Close Inventory")
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddProduct = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddProduct) {
                    NavigationStack {
                        ProductFormView(viewModel: viewModel, product: nil)
                    }
                }
            }
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue.opacity(0.8) : Color.white.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
                .shadow(color: isSelected ? Color.blue.opacity(0.3) : .clear, radius: 4, x: 0, y: 2)
        }
    }
}

struct ProductCardView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(product.name)
                .font(.title3.bold())
                .foregroundColor(.primary)
            HStack {
                Text(product.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                Text("Qty: \(product.quantity)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 6)
    }
} 