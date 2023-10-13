//
//  MainViewModel.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/12.
//

import Combine
import UIKit
import Alamofire
import Moya

class MainViewModel: BaseViewModel {
    @Published var selectedImage: UIImage?
    @Published var textprompt: String?
    @Published var imageURL: URL?
    private let provider = MoyaProvider<API>(plugins: [MoyaLogginPlugin()])
    private let services: Service
    
    init(services: Service) {
        self.services = services
    }
    
    func convertButtonDidTap() {
        guard let data = UIImage(data:(selectedImage!.jpegData(compressionQuality: 0.005)!))?.pngData() else { return }
        
        addCancellable(services.uploadInput(data, textprompt ?? "")) { [weak self] url in
            self?.imageURL  = URL(string: url) ?? URL(string: "")!
            print(url)
            print(self?.imageURL?.absoluteString)
            print("working hard")
        }
        
    }
}
