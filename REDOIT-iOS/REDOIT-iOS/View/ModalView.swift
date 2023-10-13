//
//  ModalView.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/13.
//

import SwiftUI
import Kingfisher

struct ModalView: View {
    @StateObject var viewModel: MainViewModel
    @Environment(\.presentationMode)var presentationMode
    
    var body: some View {
        VStack() {
            Spacer()
            
            KFImage(viewModel.imageURL)
                .placeholder { _ in
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: .white)
                        )
                        .frame(height: 430)
                        .background(Color.placeholder)
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 360, maxHeight: 430)
                .padding(.horizontal, 34)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.border, lineWidth: 4)
                        .padding(.horizontal, 34)
                }
                .scaledToFill()
                .padding(.horizontal, 34)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("이전 화면으로 돌아가기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(minWidth: 360)
                    .frame(height: 54)
            })
            .background(Color.black)
            .cornerRadius(5)
            .frame(minWidth: 360)
            .padding(.top, 30)
            
            Spacer(minLength: 100)
        }
    }
}
