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
    
    @IBInspectable var placeHolder: String = "Placeholder :)" { didSet { setPlaceHolder(self.placeHolder) }}
    @IBInspectable var textColor: UIColor = UIColor.black { didSet { setTextColor(self.textColor)}}
    @IBInspectable var placeHolderColor: UIColor = UIColor.lightGray { didSet { setPlaceholderColor(self.placeHolderColor)}}
    @IBInspectable var animationDuration: Double = 0.25 { didSet {} }
    @IBInspectable var textFieldFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize) { didSet{setTextFieldFont(self.textFieldFont)}}
    @IBInspectable var placeholderFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize){ didSet{ setPlaceholderFont(self.placeholderFont)}}
    @IBInspectable var errorColor: UIColor = UIColor.red {didSet { setErrorColor(errorColor)}}
    @IBInspectable var errorFont: UIFont = UIFont.systemFont(ofSize: 12) { didSet{ setErrorFont(self.errorFont)}}
    @IBInspectable var textFieldBorderColor: UIColor = UIColor.lightGray { didSet{ setTextFieldBorderColor(self.textFieldBorderColor)}}
    @IBInspectable var PlaceHolderFloatFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize - 3)
    @IBInspectable var textFieldBackgroundColor: UIColor = UIColor(red: 243/255, green: 244/255, blue: 247/255, alpha: 1.0){didSet {setTextFieldBackgroundColor()}}
    @IBInspectable var textFieldCornerRadius: CGFloat = 10.0 {didSet{setTextfieldCornerRadius()}}
    @IBInspectable var textFieldBorderWidth: CGFloat = 0.5 { didSet{setBorderWidth()}}
    var errorText: String? = nil{ didSet{ setErrorText() }}
    var text: String = ""{ get{ return textField.text ?? ""}}
    
    private var state = TextFieldState.idle
    private var errorLabelHeightConstraint: NSLayoutConstraint!
    private var placeholderCenterConstraint: NSLayoutConstraint!
    private var fieldHeightConstraint: NSLayoutConstraint!
    private var allConstraints = [NSLayoutConstraint]()
    
    var textField = UITextField()
    private let errorLabel = UILabel()
    private let placeHolderLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
        configureViews()
        configureConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fieldHeightConstraint.constant = self.bounds.height - (self.errorFont.pointSize + 5)
    }
    
    //MARK:- Private Methods
    private func configureViews(){
        
        self.backgroundColor = .clear
        // text field
        textField.textColor = self.textColor
        textField.font = self.textFieldFont
        textField.layer.borderColor = self.textFieldBorderColor.cgColor
        textField.borderStyle = .none
        textField.backgroundColor = self.textFieldBackgroundColor
        textField.layer.cornerRadius = self.textFieldCornerRadius
        configureFieldLeftView()
        addTargets()
        // placeholder label
        placeHolderLabel.text = placeHolder
        placeHolderLabel.textColor = placeHolderColor
        placeHolderLabel.font = placeholderFont
        
        // error label
        errorLabel.textColor = errorColor
        errorLabel.font = errorFont
    }
    
    private func addTargets(){
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textDidFieldDidFocus)))
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldDidStartEditing), for: .editingDidBegin)
    }
    
    private func configureConstraints(){
        addSubview(textField)
        addSubview(placeHolderLabel)
        addSubview(errorLabel)
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        // text field
        let fieldTopConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let fieldLeadingConstraint = NSLayoutConstraint(item: textField, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0)
        let fieldTrailingConstraint = NSLayoutConstraint(item: textField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -10)
        fieldHeightConstraint = textField.heightAnchor.constraint(equalToConstant: self.bounds.height - (self.errorFont.pointSize + 5))
        
        // error label
        let errorLabelLeadingConstraint = NSLayoutConstraint(item: errorLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 2.0)
        let errorLabelTrailingConstraint = NSLayoutConstraint(item: errorLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0)
        errorLabelHeightConstraint = errorLabel.heightAnchor.constraint(equalToConstant: self.errorFont.pointSize + 5)
        let errorLabelBottomConstraint = NSLayoutConstraint(item: errorLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        // place holder label
        placeholderCenterConstraint = NSLayoutConstraint(item: placeHolderLabel, attribute: .centerY, relatedBy: .equal, toItem: textField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let placeholderLeftConstraint = NSLayoutConstraint(item: placeHolderLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 10.0)
        
        let fieldConstraints = [fieldTopConstraint, fieldLeadingConstraint,
                           fieldTrailingConstraint]
        let errorLabelConstraints = [errorLabelLeadingConstraint, errorLabelTrailingConstraint,
                            errorLabelBottomConstraint]
        let placeholderLabelConstraints = [placeholderLeftConstraint, placeholderCenterConstraint]

        allConstraints = fieldConstraints + errorLabelConstraints + placeholderLabelConstraints as! [NSLayoutConstraint]
        NSLayoutConstraint.activate(allConstraints)
        self.addConstraints(allConstraints)

        errorLabelHeightConstraint.isActive = true
        fieldHeightConstraint.isActive = true
        errorLabel.addConstraint(errorLabelHeightConstraint)
        textField.addConstraint(fieldHeightConstraint)
    }
    
    private func configureFieldLeftView(){
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
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
        self.animateView {
            self.placeHolderLabel.font = self.placeholderFont
            self.placeholderCenterConstraint.constant = 0
        }
    }
    
    private func changeToFloat(){
        self.animateView {
            self.placeHolderLabel.font = self.PlaceHolderFloatFont
            self.placeholderCenterConstraint.constant = -17
        }
    }
    
    private func animateView(withBlock: @escaping()->Void){
        UIView.animate(withDuration: self.animationDuration) {
            withBlock()
            self.layoutIfNeeded()
        }
    }
    
    @objc private func textDidFieldDidFocus(){
        textField.becomeFirstResponder()
        if self.state == .idle{
            self.changeState()
        }
    }
    
    @objc private func textFieldDidEndEditing(){
        if (self.state == .idle && (textField.text ?? "").count > 0)
            || (state == .float && (textField.text ?? "").count == 0){
            changeState()
        }
    }
    
    @objc private func textFieldDidStartEditing(){
        if (self.state == .idle)
            || (state == .float && (textField.text ?? "").count == 0){
            changeState()
        }
    }
    
    private func showError(error: String){
        self.errorLabel.text = error
        self.textField.layer.borderWidth = textFieldBorderWidth
        self.textField.layer.borderColor = errorColor.cgColor
    }
    
    private func hideError(){
        self.errorLabel.text = ""
        self.textField.layer.borderWidth = 0.0
        self.textField.layer.borderColor = textFieldBorderColor.cgColor
    }
    
    //MARK:- Public methods
    func setTextfield(_ withTextField: UITextField){
        textField.removeFromSuperview()
        self.textField = withTextField
        self.removeConstraints(allConstraints)
        configureConstraints()
        addTargets()
        
        if let text = withTextField.text, !text.isEmpty{
            changeToFloat()
        }
    }
    
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

    
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
        textFieldDidEndEditing()
        return super.resignFirstResponder()
    }
    
    //MARK:- Property Methods
    private func setPlaceHolder(_ text: String){
        self.placeHolderLabel.text = text
    }
    
    private func setTextColor(_ color: UIColor){
        self.textField.textColor = color
    }

    private func setPlaceholderColor(_ color: UIColor){
        self.placeHolderLabel.textColor = color
    }
    
    private func setTextFieldFont(_ font: UIFont){
        self.textField.font = font
        self.placeHolderLabel.font = font
    }
    
    private func setPlaceholderFont(_ font: UIFont){
        self.placeHolderLabel.font = font
    }
    
    private func setErrorColor(_ color: UIColor){
        self.errorLabel.textColor = color
    }
    
    private func setErrorFont(_ font: UIFont){
        self.errorLabel.font = font
        fieldHeightConstraint.constant = self.bounds.height - (self.errorFont.pointSize + 5)
    }
    
    private func setTextFieldBorderColor(_ color: UIColor){
        self.textField.layer.borderColor = color.cgColor
    }
    
    private func setTextFieldBackgroundColor(){
        textField.backgroundColor = textFieldBackgroundColor
    }
    
    private func setTextfieldCornerRadius(){
        self.textField.layer.cornerRadius = self.textFieldCornerRadius
    }
    
    private func setErrorText(){
        if let error = errorText, !error.isEmpty{
            self.showError(error: error)
        }else {
            self.hideError()
        }
    }
    
    private func setBorderWidth(){
        if let _ = errorText{
            textField.layer.borderWidth = textFieldBorderWidth
        }
    }
}
