//
//  EditQuestionViewController.swift
//  scorpio
//
//  Created by 山浦功 on 2019/01/07.
//  Copyright © 2019 com.yamaura. All rights reserved.
//

import UIKit

class EditQuestionViewController: UITableViewController {

    enum ViewÇontrollerType {
        case new // questionの新規作成
        case update // questionの更新
    }
    enum SectionType {
        case title
        case details // choice count required
        case choice

        static var detailCellNames = ["", ""]
    }
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var requiredSwitch: UISwitch!
    @IBOutlet private weak var multipleSelectionSwitch: UISwitch!
    @IBOutlet private weak var otherSwitch: UISwitch!
    @IBOutlet private weak var choice1TextField: UITextField!
    @IBOutlet private weak var choice2TextField: UITextField!
    @IBOutlet private weak var choice3TextField: UITextField!

    var question: Question! = nil

    private var required: Bool = false
    private var multipleSelection: Bool = false
    private var other: Bool = false

    override func viewDidLoad() {
        self.required = self.question.required
        self.multipleSelection = self.question.multipleAnswer
        // choice 表示
        var row = 0
        self.question.choicesId.forEach { (id) in
            let choice = Interactor.get(object: Choice.self, primarykey: id)
            if let choice = choice {
                if choice.title == "その他" {
                    self.other = true
                    self.otherSwitch.setOn(self.other, animated: true)
                } else {
                    self.setTextInTextField(text: choice.title, row: row)
                }
            }
            row += 1
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "作成", style: .plain, target: self, action: #selector(self.doneAction(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction(_:)))
        // setup textfield
        self.titleTextField.delegate = self
        self.choice1TextField.delegate = self
        self.choice2TextField.delegate = self
        self.choice3TextField.delegate = self
        self.titleTextField.text = self.question.title
        self.titleTextField.returnKeyType = .done
        self.choice1TextField.returnKeyType = .done
        self.choice2TextField.returnKeyType = .done
        self.choice3TextField.returnKeyType = .done
        // setup uiswitch
        self.requiredSwitch.setOn(self.required, animated: false)
        self.multipleSelectionSwitch.setOn(self.multipleSelection, animated: false)
    }

    func setTextInTextField(text: String, row: Int) {
        if row == 0 {
            self.choice1TextField.text = text
        } else if row == 1 {
            self.choice2TextField.text = text
        } else if row == 2 {
            self.choice3TextField.text = text
        }
    }

    @IBAction func switchRequiredAction(_ sender: UISwitch) {
        self.required = sender.isOn
    }

    @IBAction func switchMultipleSelectAction(_ sender: UISwitch) {
        self.multipleSelection = sender.isOn
    }

    @IBAction func switchOtherAction(_ sender: UISwitch) {
        self.other = sender.isOn
    }

    @objc func cancelAction(_ sender: Any) {
        if let navigation = self.navigationController {
            navigation.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        print("cancel clicked")
    }

    @objc func doneAction(_ sender: Any) {
        // 記述漏れを検出
        guard let title = self.getText(from: self.titleTextField) else {
            self.showSimpleAlert(title: "エラー", message: "タイトルがありません。")
            return
        }
        guard let choice1 = self.getText(from: self.choice1TextField) else {
            self.showSimpleAlert(title: "エラー", message: "答え1がありません。")
            return
        }
        guard let choice2 = self.getText(from: self.choice2TextField) else {
            self.showSimpleAlert(title: "エラー", message: "答え2がありません。")
            return
        }
        guard let choice3 = self.getText(from: self.choice2TextField) else {
            self.showSimpleAlert(title: "エラー", message: "答え3がありません。")
            return
        }

        if self.question == nil {
            // データの作成
            var choices = [
                self.setChoice(choiceTitle: choice1, choiceID: nil),
                self.setChoice(choiceTitle: choice2, choiceID: nil),
                self.setChoice(choiceTitle: choice3, choiceID: nil)
            ]
            if self.other { choices.append(self.setChoice(choiceTitle: "その他", choiceID: nil)) }
            if let question = self.question {
                question.title = title
                question.typeId = "01"
                question.choicesId.append(objectsIn: choices)
                question.required = self.required
                question.multipleAnswer = self.multipleSelection
                question.updatedAt = Date()
                Interactor.update(object: question)
            }
        } else {
            guard let target = question else { return }
            target.title = self.titleTextField.text!
            var targetChoices = Array(target.choicesId)
            var choices = [
                self.setChoice(choiceTitle: choice1, choiceID: targetChoices[0]),
                self.setChoice(choiceTitle: choice2, choiceID: targetChoices[1]),
                self.setChoice(choiceTitle: choice2, choiceID: targetChoices[2]),
            ]
            if self.other { choices.append(self.setChoice(choiceTitle: "その他", choiceID: nil))}
            target.choicesId.removeAll()
            target.choicesId.append(objectsIn: choices)
            target.updatedAt = Date()
            Interactor.update(object: target)
        }
        if let navigation = self.navigationController {
            navigation.dismiss(animated: true, completion: nil)
        }
    }

    private func getText(from: UITextField) -> String? {
        if let text = from.text, !text.isEmpty {
            // 文字列が存在
            return text
        } else {
            return nil
        }
    }

    private func setChoice(choiceTitle: String, choiceID: String?) -> String {
        if let choiceID = choiceID {
            if !choiceID.isEmpty {
                guard let target = Interactor.get(object: Choice.self, primarykey: choiceID) else { return "" }
                target.title = choiceTitle
                target.updatedAt = Date()
                Interactor.update(object: target)
                return target.id
            }
        }
        // 更新ではなく新規作成
        let new = Choice()
        new.id = UUID().uuidString
        new.title = choiceTitle
        new.updatedAt = Date()
        new.createdAt = Date()
        Interactor.update(object: new)
        return new.id
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.titleTextField.isFirstResponder {
            self.resignFirstResponder()
        }
    }
}

extension EditQuestionViewController: StoryboardInstantiable {}

extension EditQuestionViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.titleTextField.isFirstResponder {
            self.titleTextField.resignFirstResponder()
        }
    }
}
