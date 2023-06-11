//
//  CMTime+Ext.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 10.06.2023.
//

import UIKit
import CoreMedia

extension CMTime {
    func formatString() -> String{
        let totalSecond = Int(CMTimeGetSeconds(self))
        let second = totalSecond % 60
        let minutes = totalSecond / 60
        let formatString = String(format: "%02d : %02d", minutes, second)
        return formatString
    }
}
