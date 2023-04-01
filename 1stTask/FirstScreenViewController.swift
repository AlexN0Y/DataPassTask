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
    
    @IBAction private func nextButtonTapped() {
        let inputStoryboard = UIStoryboard(name: "InputStoryboard", bundle: nil)
        let secondViewController = inputStoryboard.instantiateViewController(withIdentifier: "SecondScreenVC") as! SecondScreenViewController
        secondViewController.delegate = self
        secondViewController.onSave = { [weak self] closureText in
            self?.closureLabel.text = closureText
        }
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    @objc private func onTextEntered(_ notification: Notification) {
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
