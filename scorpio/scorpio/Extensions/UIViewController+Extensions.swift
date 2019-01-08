//
//  UIViewController+Extensions.swift
//  scorpio
//
//  Created by 山浦功 on 2019/01/09.
//  Copyright © 2019 com.yamaura. All rights reserved.
//

import UIKit

extension UIViewController {

    func showSimpleAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
