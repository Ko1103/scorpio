//
//  RootViewController.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {

    let wireframe = RootWireframe()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let launchViewController = LaunchViewController()
        self.wireframe.transition(to: launchViewController)
    }
}
