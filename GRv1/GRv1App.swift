//
//  GRv1App.swift
//  GRv1
//
//  Created by Darnell Carter on 6/3/25.
//

import SwiftUI
import SwiftData

@main
struct GRv1App: App {
    @State private var showLanding = true
    @State private var showLandingPage = true

    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                if showLandingPage {
                    LandingPageView(showLandingPage: $showLandingPage, showLanding: $showLanding)
                } else if showLanding {
                    LandingView(showLandingPage: $showLandingPage, showLanding: $showLanding)
                } else {
                    ProductListView(showLanding: $showLanding)
                }
            } else {
                ProductListView(showLanding: .constant(false))
            }
        }
    }
}
