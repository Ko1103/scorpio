//
//  QuestionnaireViewController.swift
//  scorpio
//
//  Created by 山浦功 on 2019/01/04.
//  Copyright © 2019 com.yamaura. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let wireframe = RootWireframe()

    override func viewDidLoad() {
        super.viewDidLoad()
        // setup navigation buttons
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "結果", style: .plain, target: self, action: #selector(self.segueToResult))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.segueToNew))
        // setup tableview
    }

    @objc private func segueToNew() {
        let new = NewQuestionnaireViewController.instantiate()
        self.wireframe.push(destination: new)
    }

    @objc private func segueToResult() {
        let result = ResultViewController.instantiate()
        self.wireframe.push(destination: result)
    }
}

extension QuestionnaireViewController: StoryboardInstantiable {}

extension QuestionnaireViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
