//
//  RadioViewController.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import UIKit

final class QuestionViewController: UIViewController {

    var questionnaireId: String!
    var userId: String!
    var questions: [Question] = []

    override func viewDidLoad() {
        if self.questionnaireId.isEmpty || self.userId.isEmpty {
            // show alert that this view failed to load data
        }
        guard let questionnaire = Interactor.get(object: Questionnaire.self, primarykey: self.questionnaireId) else { return }
        questionnaire.questionsId.forEach({
            if let new = Interactor.get(object: Question.self, primarykey: $0) {
                self.questions.append(new)
            }
        })
    }
}

extension QuestionViewController: StoryboardInstantiable {}
