//
//  ViewController.swift
//  WTTextField
//
//  Created by Wasi Tariq on 7/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: WTTextField!
    private var isErrorShown = false
    private var isFloated = false
    let field = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        textView.placeHolder = "Enter Email"
    }
    
    
    
    @objc func tap(){
        textView.resignFirstResponder()
    }
    
    @IBAction func hideError(_ sender: Any) {
        textView.errorText = nil
    }
    
    @IBAction func showError(_ sender: Any) {
        textView.errorText = "Invalid Email"
    }
}
