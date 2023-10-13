//
//  ImageDragView.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/12.
//

import SwiftUI

struct ImageDragView: View {
    @State var selectedImage: UIImage
    @State var firstTap: Bool = false
    @State var firstPosition: CGPoint?
    @State var dragPosition: CGPoint = .zero
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(uiImage: selectedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .simultaneousGesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .onChanged { _ in
                            firstTap = true
                            firstPosition = nil
                            dragPosition = .zero
                        }
                )
                .simultaneousGesture(
                    DragGesture(minimumDistance: 30, coordinateSpace: .local)
                        .onChanged {
                            if firstTap {
                                firstPosition = $0.location
                                firstTap = false
                            }
                            dragPosition = $0.location
                        }
                )
            if let firstPosition {
                let x = dragPosition.x - firstPosition.x
                let y = dragPosition.y - firstPosition.y
                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .offset(x: x >= 0 ? firstPosition.x : dragPosition.x,
                            y: y >= 0 ? firstPosition.y : dragPosition.y)
                    .frame(width: x < 0 ? -x : x, height: y < 0 ? -y : y)
            }
        }
    }
}
