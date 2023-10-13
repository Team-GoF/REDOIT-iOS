//
//  REDOIT_iOSApp.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/12.
//

import SwiftUI

@main
struct REDOIT_iOSApp: App {
    var body: some Scene {
        WindowGroup {
//            MainView(viewModel: MainViewModel(services: Service()))
            OnboardingView()
        }
    }
}
