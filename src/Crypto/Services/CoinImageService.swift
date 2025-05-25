//
//  CoinImageService.swift
//  Crypto
//
//  Created by Nayan on 24/05/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (returnedImage) in
                    guard let self = self else { return }
                
                    self.image = returnedImage
                    self.imageSubscription?.cancel()
                    
                    // save the retrieved image if it isn't nil
                    guard let downloadedImage = returnedImage else { return }
                    self.fileManager.saveImage(
                        image: downloadedImage,
                        imageName: self.imageName,
                        folderName: self.folderName,
                    )
            })
    }
}
