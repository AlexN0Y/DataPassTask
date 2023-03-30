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

class SecondScreenViewController: UIViewController {
    @IBOutlet private weak var delegateTextField: UITextField!
    @IBOutlet private weak var closureTextField: UITextField!
    @IBOutlet private weak var notificationTextField: UITextField!
    
    weak var delegate: TextFieldDelegate?
    var onSave: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let text = delegateTextField.text {
            delegate?.didEnterText(text)
        }
        if let text = closureTextField.text {
            onSave?(text)
        }
        if let text = notificationTextField.text {
            NotificationCenter.default.post(name: Notification.Name("TextEntered"), object: nil, userInfo: ["text": text])
        }
    }
    
}
