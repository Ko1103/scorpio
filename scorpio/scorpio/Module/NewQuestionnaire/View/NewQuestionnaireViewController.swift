//
//  NewQuestionnaireViewController.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import UIKit

class NewQuestionnaireViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var questionCountStepper: UIStepper!
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var questionCount: Double = 1
    private var questions: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "作成", style: .plain, target: self, action: #selector(self.createQuestionnaireAction))
        // setup view delegate
        self.titleTextField.delegate = self
        self.titleTextField.returnKeyType = .done
        self.titleTextField.placeholder = "アンケートのタイトルを入力"
        self.questionCountStepper.maximumValue = 100
        self.questionCountStepper.minimumValue = 1
        self.questionCountStepper.stepValue = 1
        self.questionCountStepper.addTarget(self, action: #selector(self.stepperClicked(stepper:)), for: .touchUpInside)
        let count = Int(self.questionCount)
        self.questionCountLabel.text = String(count)
    }

    @objc func createQuestionnaireAction() {
        // 作成
        self.navigationController?.popViewController(animated: true)
    }

    @objc func stepperClicked(stepper: UIStepper) {
        self.questionCount = stepper.value
        let count = Int(self.questionCount)
        self.questionCountLabel.text = String(count)
        self.tableView.reloadData()
    }
}

extension NewQuestionnaireViewController: StoryboardInstantiable {}

extension NewQuestionnaireViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.titleTextField.isFirstResponder {
            self.titleTextField.resignFirstResponder()
        }
    }
}

extension NewQuestionnaireViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(self.questionCount)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select tableview")
        let editQuestion = EditQuestionViewController.instantiate()
        if self.questions.count > indexPath.row {
            let question = self.questions[indexPath.row]
            editQuestion.question = question
        }
        self.navigationController?.pushViewController(editQuestion, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell")!
        if  indexPath.row < self.questions.count {
            let question = self.questions[indexPath.row]
            if question.title.isEmpty {
                cell.textLabel?.text = "質問\(indexPath.row + 1)"
            }
            cell.textLabel?.text = question.title
        } else {
            cell.textLabel?.text = "質問\(indexPath.row + 1)"
        }
        return cell
    }
}
