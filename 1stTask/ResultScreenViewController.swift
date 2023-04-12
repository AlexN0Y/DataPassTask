//
//  FirstScreenViewController.swift
//  1stTask
//
//  Created by Alex Gav on 28.03.2023.
//

import UIKit


class ResultScreenViewController: UIViewController {
    
    @IBOutlet private weak var delegateLabel: UILabel! {
        didSet {
            delegateLabel.text = "Waiting for change"
        }
    }
    @IBOutlet private weak var closureLabel: UILabel! {
        didSet {
            closureLabel.text = "Waiting for change"
        }
    }
    @IBOutlet private weak var notificationLabel: UILabel! {
        didSet {
            notificationLabel.text = "Waiting for change"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onTextEntered), name: Notification.Name("TextEntered"), object: nil)
    }
    
    @IBAction private func nextButtonTapped() {
        let inputStoryboard = UIStoryboard(name: "InputStoryboard", bundle: nil)
        let secondViewController = inputStoryboard.instantiateViewController(withIdentifier: "SecondScreenVC") as! InputScreenViewController
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
    
}

extension ResultScreenViewController: TextFieldDelegate {
    func didEnterText(_ text: String) {
        delegateLabel.text = text
    }
}
