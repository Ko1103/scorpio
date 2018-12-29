//
//  StoryboardInstantiable.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import UIKit

protocol Instantiable {
    static func instantiate() -> Self
}

protocol StoryboardInstantiable: Instantiable {
    static var storyboard: UIStoryboard { get }
}

extension StoryboardInstantiable where Self: UIViewController {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: NSStringFromClass(self).components(separatedBy: ".").last!, bundle: Bundle(for: self))
    }

    static func instantiate() -> Self {
        // swiftlint:disable:next force_cast
        return storyboard.instantiateInitialViewController() as! Self
    }
}
