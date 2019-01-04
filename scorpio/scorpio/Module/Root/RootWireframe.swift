//
//  RootWireframe.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import UIKit

protocol Wireframe {
    func transition(to viewController: UIViewController)
    func push(destination: UIViewController)
    func popToRoot()
}

struct RootWireframe: Wireframe {
    func transition(to viewController: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let root = appDelegate.window?.rootViewController as? RootViewController else { return }
        if !root.children.isEmpty {
            root.children.forEach { (child) in
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
        root.addChild(viewController)
        viewController.view.frame = UIScreen.main.bounds
        root.view.addSubview(viewController.view)
        viewController.didMove(toParent: root)
    }

    func push(destination: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let root = appDelegate.window?.rootViewController as? RootViewController else { return }
        if let child = root.children.first {
            guard let navigationController = child as? UINavigationController else { return }
            navigationController.pushViewController(destination, animated: false)
        }
    }

    func popToRoot() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let root = appDelegate.window?.rootViewController as? RootViewController else { return }
        if let child = root.children.first {
            guard let navigationController = child as? UINavigationController else { return }
            navigationController.popToRootViewController(animated: false)
        }
    }
}

extension RootWireframe {
    func transitionToMain() {
        let navigation = UINavigationController()
        navigation.setViewControllers([QuestionnaireViewController.instantiate()], animated: false)
        self.transition(to: navigation)
    }
}
