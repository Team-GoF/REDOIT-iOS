//
//  OnboardingView.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/13.
//

import SwiftUI
import UIKit

struct OnboardingView: View {
    @State var isNaviToMain = false

    var body: some View {
        VStack(spacing: 0) {
            OnboardingImageViewer()
            
            Button(action: {
                isNaviToMain = true
            }, label: {
                Text("시작하기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .background(Color.white)
                    .frame(width: 360, height: 52)
            })
            .padding(.horizontal, 34)
            .frame(width: 360, height: 52)
            .fullScreenCover(isPresented: $isNaviToMain) {
                MainView(viewModel: MainViewModel(services: Service()))
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.top)
    }
}
