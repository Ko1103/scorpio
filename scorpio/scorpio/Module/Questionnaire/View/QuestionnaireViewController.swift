//
//  QuestionnaireViewController.swift
//  scorpio
//
//  Created by 山浦功 on 2019/01/04.
//  Copyright © 2019 com.yamaura. All rights reserved.
//

import UIKit
import RxSwift


class QuestionnaireViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    private var items: Observable<[Questionnaire]> {
//        return Observable.create { (observer: AnyObserver<[Questionnaire]>) -> Disposable in
//            let items: [Questionnaire] = Interactor.getAll()
//            observer.onNext(items)
//            observer.onCompleted()
//            return Disposables.create()
//        }
//    }
    private let wireframe = RootWireframe()

    override func viewDidLoad() {
        super.viewDidLoad()
        // setup navigation buttons
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "結果", style: .plain, target: self, action: #selector(self.segueToResult))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.segueToNew))
        // setup tableview
        let items = Observable.create { (observer: AnyObserver<[Questionnaire]>) -> Disposable in
            let items: [Questionnaire] = Interactor.getAll()
            observer.onNext(items)
            observer.onCompleted()
            return Disposables.create()
        }
        self.tableView.rx.
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                print("押されました。")
            })
            .disposed
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
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
