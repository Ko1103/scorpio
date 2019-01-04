//
//  LaunchViewController.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import UIKit

final class LaunchViewController: UIViewController {
    let wireframe = RootWireframe()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.spWhite
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let navigation = UINavigationController()
        navigation.setNavigationBarHidden(true, animated: false)
        self.wireframe.transitionToMain()
    }
}
