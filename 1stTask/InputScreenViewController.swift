//
//  SecondScreenViewController.swift
//  1stTask
//
//  Created by Alex Gav on 28.03.2023.
//

import UIKit

protocol TextFieldDelegate: AnyObject {
    func didEnterText(_ text: String)
}

enum TextTag: Int {
    case delegate = 1
    case closure = 2
    case notification = 3
}

class InputScreenViewController: UIViewController {
    @IBOutlet private weak var delegateTextField: UITextField!
    @IBOutlet private weak var closureTextField: UITextField!
    @IBOutlet private weak var notificationTextField: UITextField!
    
    weak var delegate: TextFieldDelegate?
    var onSave: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTextField.delegate = self
        delegateTextField.tag = 1
        closureTextField.delegate = self
        closureTextField.tag = 2
        notificationTextField.delegate = self
        notificationTextField.tag = 3
    }
    
    @IBAction private func delegateTextFieldEdited() {
        if let text = delegateTextField.text {
            delegate?.didEnterText(text)
        }
    }
    
    @IBAction private func closureTextFieldEdited() {
        if let text = closureTextField.text {
            onSave?(text)
        }
    }
    
    @IBAction private func notificationTextFieldEdited() {
        if let text = notificationTextField.text {
            NotificationCenter.default.post(name: Notification.Name("TextEntered"), object: nil, userInfo: ["text": text])
        }
    }
    
}

extension InputScreenViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        switch TextTag(rawValue: textField.tag) {
        case .delegate:
            delegate?.didEnterText(text)
        case .closure:
            onSave?(text)
        case .notification:
            NotificationCenter.default.post(name: Notification.Name("TextEntered"), object: nil, userInfo: ["text": text])
        case .none:
            break
        }
        
    }
}
