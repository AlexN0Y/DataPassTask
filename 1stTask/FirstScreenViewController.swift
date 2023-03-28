//
//  FirstScreenViewController.swift
//  1stTask
//
//  Created by Alex Gav on 28.03.2023.
//

import UIKit


class FirstScreenViewController: UIViewController {
    
    @IBOutlet private weak var delegateLabel: UILabel!
    @IBOutlet private weak var closureLabel: UILabel!
    @IBOutlet private weak var notificationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateLabel.text = "Waiting for change"
        closureLabel.text = "Waiting for change"
        notificationLabel.text = "Waiting for change"
        NotificationCenter.default.addObserver(self, selector: #selector(onTextEntered), name: Notification.Name("TextEntered"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondScreenVC" {
            if let destinationVC = segue.destination as? SecondScreenViewController {
                destinationVC.delegate = self
                destinationVC.onSave = { [weak self] closureText in
                    self?.closureLabel.text = closureText
                }
            }
        }
    }
    
    @objc func onTextEntered(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        notificationLabel.text = text
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension FirstScreenViewController: TextFieldDelegate {
    func didEnterText(_ text: String) {
        delegateLabel.text = text
    }
}
