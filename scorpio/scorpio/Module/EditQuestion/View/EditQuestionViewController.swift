//
//  EditQuestionViewController.swift
//  scorpio
//
//  Created by 山浦功 on 2019/01/07.
//  Copyright © 2019 com.yamaura. All rights reserved.
//

import UIKit

class EditQuestionViewController: UITableViewController {
    enum SectionType {
        case title
        case details // choice count required
        case choice

        static var detailCellNames = ["", ""]
    }
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var requiredSwitch: UISwitch!
    @IBOutlet private weak var multipleSelectionSwitch: UISwitch!

    var question: Question?

    private var required: Bool = false
    private var multipleSelection: Bool = false

    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "作成", style: .plain, target: self, action: #selector(self.doneAction(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction(_:)))
        // setup textfield
        self.titleTextField.delegate = self
        self.titleTextField.returnKeyType = .done
        self.requiredSwitch.setOn(self.required, animated: false)
        self.multipleSelectionSwitch.setOn(self.multipleSelection, animated: false)
    }

    @IBAction func switchRequiredAction(_ sender: UISwitch) {
        self.required = sender.isOn
    }

    @IBAction func switchMultipleSelectAction(_ sender: UISwitch) {
        self.multipleSelection = sender.isOn
    }

    @objc func cancelAction(_ sender: Any) {
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc func doneAction(_ sender: Any) {
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
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
