//
//  CommonExtension.swift
//  simpleTODO
//
//  Created by 윤아영(Yun, AYoung) on 2020/01/21.
//  Copyright © 2020 ayoung. All rights reserved.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        let nameSpaceClassName = NSStringFromClass(self)
        guard let className = nameSpaceClassName.components(separatedBy: ".").last else {
            return nameSpaceClassName
        }
        return className
    }
}

extension UIViewController {
    static var reuseIdentifier: String {
        let nameSpaceClassName = NSStringFromClass(self)
        guard let className = nameSpaceClassName.components(separatedBy: ".").last else {
            return nameSpaceClassName
        }
        return className
    }
}
