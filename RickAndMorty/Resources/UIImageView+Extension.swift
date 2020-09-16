//
//  UIImageView+Extension.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import UIKit

extension UIImageView {
    /// Sets image for UIImageView from url if successful will use image from url if failure we will use image from assets
    /// - Parameter url: url string used to make request
    func getImage(for url: String) {
        let networkManager = NetworkManager()
        networkManager.getImage(for: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let uiImage):
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.image = UIImage(named: "NoImageRick")
                }
                
            }
            
        }
    }
    
}
