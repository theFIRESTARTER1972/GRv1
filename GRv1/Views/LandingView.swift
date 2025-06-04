import SwiftUI

struct LandingView: View {
    @Binding var showLandingPage: Bool
    @Binding var showLanding: Bool

    var body: some View {
        ZStack {
            // Visually appealing gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.green.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()
                VStack(spacing: 20) {
                    Text("The Mission:")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(radius: 8)
                        .padding(.horizontal, 24)
                    Text("To take the struggle out of running a grass roots organization.")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(radius: 8)
                        .padding(.horizontal, 24)
                }
                Spacer(minLength: 40) // Reduced from 80 to 40 for 50% closer
                VStack(spacing: 20) {
                    Button(action: {
                        showLanding = false
                        showLandingPage = false
                    }) {
                        Text("Go to Inventory")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .foregroundColor(.blue)
                            .cornerRadius(14)
                            .shadow(radius: 4)
                    }
                    .padding(.horizontal, 40)

                    Button(action: {
                        closeApp()
                    }) {
                        Text("Quit")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color.red.opacity(0.9))
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .shadow(radius: 4)
                    }
                    .padding(.horizontal, 70) // 75% of 40 (Go to Inventory) is 70
                }
                Spacer()
            }
            .frame(maxWidth: 600)
            .padding(.vertical, 60)
        }
    }

    private func closeApp() {
        exit(0)
    }
} 
