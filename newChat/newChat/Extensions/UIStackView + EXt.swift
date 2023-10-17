//
//  UIStackView + EXt.swift
//  newChat
//
//  Created by Марина on 16.10.2023.
//

import Foundation
import UIKit
extension UIStackView {
    convenience init(
//        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill)
    {
//        self.init(arrangedSubviews: arrangedSubviews)
            self.init()
            self.alignment = alignment
            self.axis = axis
            self.distribution = distribution
            self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
