//
//  UIImageView+Ext.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 6.05.2023.
//

import UIKit

extension UIImageView {
    func customMode() {
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
