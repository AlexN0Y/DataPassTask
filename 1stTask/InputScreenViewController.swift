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

class InputScreenViewController: UIViewController {
    @IBOutlet private weak var delegateTextField: UITextField! {
        didSet {
            delegateTextField.delegate = self
        }
    }
    @IBOutlet private weak var closureTextField: UITextField! {
        didSet {
            closureTextField.delegate = self
        }
    }
    @IBOutlet private weak var notificationTextField: UITextField! {
        didSet {
            notificationTextField.delegate = self
        }
    }
    
    weak var delegate: TextFieldDelegate?
    var onSave: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if textField.isEqual(delegateTextField) {
            delegate?.didEnterText(text)
        } else if textField.isEqual(closureTextField) {
            onSave?(text)
        } else if textField.isEqual(notificationTextField) {
            NotificationCenter.default.post(name: Notification.Name("TextEntered"), object: nil, userInfo: ["text": text])
        }
    }
    
}
