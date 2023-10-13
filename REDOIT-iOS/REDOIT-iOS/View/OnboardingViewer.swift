//
//  OnboardingViewer.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/13.
//

import SwiftUI

struct OnboardingImageViewer: View {

    private let onboardingViews: [(image: Image, color: Color)] = [
        (Image("first"), .black),
        (Image("second"), .black),
        (Image("third"), .black)
    ]

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.white)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "placeholderColor")
    }

    var body: some View {
        TabView {
            ForEach(self.onboardingViews.indices, id: \.self) { index in
                VStack {
                    ZStack(alignment: .center) {
                        onboardingViews[index].image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 705)
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .edgesIgnoringSafeArea(.top)
    }

}
