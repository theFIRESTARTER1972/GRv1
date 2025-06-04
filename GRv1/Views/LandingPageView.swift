import SwiftUI
#if os(iOS)
import CoreMotion
#endif

@available(iOS 16.0, *)
struct LandingPageView: View {
    @Binding var showLandingPage: Bool
    @Binding var showLanding: Bool
    #if os(iOS)
    @State private var motionManager = CMMotionManager()
    #endif
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // Responsive background image with parallax effect
            Image("neighborhood")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(x: xOffset, y: yOffset)
                .onAppear {
                    #if os(iOS)
                    startMotionUpdates()
                    #endif
                }
            // Black circle/button with 'ENTER' at center bottom
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showLandingPage = false
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 80, height: 80)
                                .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 4)
                            Text("ENTER")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 40)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    #if os(iOS)
    private func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
                guard let motion = motion else { return }
                
                // Adjust the multiplier to control the parallax effect intensity
                let multiplier: CGFloat = 50
                xOffset = CGFloat(motion.attitude.roll) * multiplier
                yOffset = CGFloat(motion.attitude.pitch) * multiplier
            }
        }
    }
    #endif
} 
