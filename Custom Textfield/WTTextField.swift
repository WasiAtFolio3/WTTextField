//
//  WTTextField.swift
//  Custom Textfield
//
//  Created by Wasi Tariq on 7/5/19.
//  Copyright © 2019 Folio3. All rights reserved.
//

import UIKit

enum TextFieldState{
    case idle
    case float
}

@IBDesignable class WTTextField: UIView {
    
    @IBInspectable var placeHolder: String = "" { didSet { setPlaceHolder(self.placeHolder) }}
    @IBInspectable var textColor: UIColor = UIColor.black { didSet { setTextColor(self.textColor)}}
    @IBInspectable var placeHolderColor: UIColor = UIColor.lightGray { didSet { setPlaceholderColor(self.placeHolderColor)}}
    @IBInspectable var animationDuration: CGFloat = 0.45 { didSet {} }
    @IBInspectable var textFielfFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize) { didSet{setTextFieldFont(self.textFielfFont)}}
    @IBInspectable var placeholderFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize){ didSet{ setPlaceholderFont(self.placeholderFont)}}
    @IBInspectable var errorColor: UIColor = UIColor.red {didSet { setErrorColor(errorColor)}}
    @IBInspectable var errorFont: UIFont = UIFont.systemFont(ofSize: 12) { didSet{ setErrorFont(self.errorFont)}}
    @IBInspectable var textFieldBorderColor: UIColor = UIColor.lightGray { didSet{ setTextFieldBorderColor(self.textFieldBorderColor)}}
    
    private var state = TextFieldState.idle
    private var errorLabelHeightConstraint: NSLayoutConstraint!
    
    let textField = UITextField()
    private let errorLabel = UILabel()
    private let placeHolderLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        configureConstraints()
        configureViews()
        
    }
 
    //MARK:- Private Methods
    private func configureViews(){
        self.backgroundColor = .black
        // text field
        textField.text = "dfsg"
        textField.textColor = self.textColor
        textField.backgroundColor = UIColor.yellow
        textField.font = self.textFielfFont
        textField.layer.borderColor = self.textFieldBorderColor.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10.0
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textDidFieldDidFocus)))
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        
        // placeholder label
        placeHolderLabel.text = placeHolder
        placeHolderLabel.textColor = placeHolderColor
        placeHolderLabel.font = placeholderFont
        
        // error label
        errorLabel.textColor = errorColor
        errorLabel.font = errorFont
        
        
    }
    
    private func configureConstraints(){
        addSubview(textField)
        addSubview(placeHolderLabel)
        addSubview(errorLabel)
        // text field
        let fieldTopConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let fieldLeadingConstraint = NSLayoutConstraint(item: textField, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 10)
        let fieldTrailingConstraint = NSLayoutConstraint(item: textField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 10)
        let fieldBottomConstraint = NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: errorLabel, attribute: .top, multiplier: 1.0, constant: 0)
        
        // error label
        let errorLabelLeadingConstraint = NSLayoutConstraint(item: errorLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0)
        let errorLabelTrailingConstraint = NSLayoutConstraint(item: errorLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0)
        errorLabelHeightConstraint = errorLabel.heightAnchor.constraint(equalToConstant: 20)
        let errorLabelBottomConstraint = NSLayoutConstraint(item: errorLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
//
        let fieldConstraints = [fieldTopConstraint, fieldLeadingConstraint,
                           fieldTrailingConstraint, fieldBottomConstraint]
        let errorLabelConstraints = [errorLabelLeadingConstraint, errorLabelTrailingConstraint,
                            errorLabelBottomConstraint]
        fieldConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        errorLabelConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        self.addConstraints(fieldConstraints)
        NSLayoutConstraint.activate(fieldConstraints)
        self.addConstraints(errorLabelConstraints)
        errorLabelHeightConstraint.isActive = true
        errorLabel.addConstraint(errorLabelHeightConstraint)
    }
    
    private func changeState(){
        if self.state == .idle{
            changeToFloat()
            self.state = .float
        }else if self.state == .float{
            changeToIdle()
            self.state = .idle
        }
    }
    
    private func changeToIdle(){
        
    }
    
    private func changeToFloat(){
        
    }
    
    @objc func textDidFieldDidFocus(){
        textField.becomeFirstResponder()
        if self.state == .idle{
            self.changeState()
        }
    }
    
    @objc func textFieldDidEndEditing(){
        if (self.state == .idle && (textField.text ?? "").count > 0)
            || (state == .float && (textField.text ?? "").count == 0){
            changeState()
        }
    }
    
    //MARK:- Public methods
    func setText(_ text: String){
        // if text field is in idle state and text is not empty
        //OR
        // text is empty and field is in float state
        // then change the state of the field.
        if (self.state == .idle && !text.isEmpty)
            || (self.state == .float && text.isEmpty){
            changeState()
            self.textField.text = text
        }
    }
    
    func showError(error: String){
        self.errorLabel.text = error
        self.textField.layer.borderColor = errorColor.cgColor
    }
    
    func hideError(){
        self.errorLabel.text = ""
        self.textField.layer.borderColor = textFieldBorderColor.cgColor
    }
    
    //MARK:- Property Methods
    func setPlaceHolder(_ text: String){
        self.placeHolderLabel.text = text
    }
    
    func setTextColor(_ color: UIColor){
        self.textField.textColor = color
    }

    func setPlaceholderColor(_ color: UIColor){
        self.placeHolderLabel.textColor = color
    }
    
    func setTextFieldFont(_ font: UIFont){
        self.textField.font = font
        self.placeHolderLabel.font = font
    }
    
    func setPlaceholderFont(_ font: UIFont){
        self.placeHolderLabel.font = font
    }
    
    func setErrorColor(_ color: UIColor){
        self.errorLabel.textColor = color
    }
    
    func setErrorFont(_ font: UIFont){
        self.errorLabel.font = font
    }
    
    func setTextFieldBorderColor(_ color: UIColor){
        self.textField.layer.borderColor = color.cgColor
    }
}
