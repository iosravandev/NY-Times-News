//
//  UILabel+Extensions.swift
//  NewYork Times News
//
//  Created by Ravan on 22.11.24.
//

import UIKit

extension UILabel {
    
    func getStartEndPoints(text: String) -> (start: CGFloat, end: CGFloat) {
        
        let fullText = self.text ?? ""
        let signInRange = (fullText as NSString).range(of: "Sign up")
        let labelWidth = self.bounds.width
        let textLength = CGFloat(fullText.count)
        let characterWidth = labelWidth / textLength
        let startX = CGFloat(signInRange.location) * characterWidth
        let endX = CGFloat(signInRange.upperBound) * characterWidth
        
        return (startX, endX)
    }
    
}
