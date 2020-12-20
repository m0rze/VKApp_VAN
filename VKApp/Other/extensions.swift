//
//  extensions.swift
//  VKApp
//
//  Created by Алексей Виноградов on 30.11.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


