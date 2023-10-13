//
//  ContentView.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/12.
//

import SwiftUI
import PhotosUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
//    @StateObject private var keyboardHandler = KeyboardHandler()
    var placeholder: String = "변환할 이미지에 대한 설명을 작성해 주세요."
    @State var text: String = ""
    @FocusState var isFocused: Bool
    @State var isShowingActionSheet = false
    @State var isShowingImagePicker = false
    @State var isShowingCameraPicker = false
    @State var isPresentingModal = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
                .ignoresSafeArea()
            Image("BackgroundImage")
                .resizable()
                .opacity(0.6)
                .ignoresSafeArea()
            Image("TapeImage")
                .resizable()
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                if let selectedImage = viewModel.selectedImage {
                    ZStack(alignment: .topTrailing) {
                        ImageDragView(selectedImage: selectedImage)
                            .scaledToFit()
                            .frame(maxHeight: 430)
                            .background(Color.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.border, lineWidth: 4)
                            }
                        Button {
                            withAnimation(.default) {
                                viewModel.selectedImage = nil
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(.white, .black)
                        }
                        .padding(18)
                    }
                    
                } else {
                    Button(action: {
                        isShowingActionSheet.toggle()
                    }, label: {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.border, lineWidth: 4)
                            .background {
                                ZStack(alignment: .center) {
                                    Color.white
                                    Image("cameraImage")
                                }
                            }
                            .frame(maxHeight: 430)
                    })
                }
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .cornerRadius(5)
                        .disableAutocorrection(true)
                        .foregroundColor(.text)
                        .background(Color.white)
                        .frame(height: 150)
                        .font(.system(size: 16, weight: .regular))
                        .transparentScrolling()
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.border, lineWidth: 4)
                                .frame(height: 150)
                        }
                        .onChange(of: text) { _ in
                            text = text.precomposedStringWithCanonicalMapping
                            viewModel.textprompt = text
                        }
                    
                    Text(placeholder)
                        .foregroundColor(.placeholder)
                        .font(.system(size: 16, weight: .regular))
                        .padding(.all, 20)
                        .cornerRadius(4)
                        .opacity(text.isEmpty ? 1 : 0)
                        .onTapGesture {
                            isFocused = true
                        }
                }
                .padding(.top, 18)
                
                Button(action: {
                    viewModel.convertButtonDidTap()
                    isPresentingModal.toggle()
                }, label: {
                    Spacer()
                    Text("이미지 변환하기")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                })
                .frame(height: 53)
                .background(Color.black)
                .cornerRadius(5)
                .padding(.top, 24)
//                .fullScreenCover(isPresented: $isPresentingModal) {
//                    ModalView(viewModel: viewModel)
//                }
                .sheet(isPresented: $isPresentingModal) {
                    ModalView(viewModel: viewModel)
                }
                
                Spacer(minLength: 60)
            }
            .padding(.horizontal, 34)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .imagePicker(isShow: $isShowingImagePicker, uiImage: $viewModel.selectedImage)
        .cameraPicker(isShow: $isShowingCameraPicker, uiImage: $viewModel.selectedImage)
        .confirmationDialog("", isPresented: $isShowingActionSheet, titleVisibility: .hidden) {
            Button("사진 가져오기") {
                isShowingActionSheet = false
                isShowingImagePicker.toggle()
            }
            Button("사진 촬영하기") {
                isShowingActionSheet = false
                isShowingCameraPicker.toggle()
            }
        }
    }
}

public extension View {
    func transparentScrolling() -> some View {
        return onAppear {
            UITextView.appearance().backgroundColor = .clear
            UITextView.appearance().textContainerInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 20)
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
