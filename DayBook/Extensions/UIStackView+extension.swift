//
//  UIStackView+extension.swift
//  DayBook
//
//  Created by Илья on 6/13/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
