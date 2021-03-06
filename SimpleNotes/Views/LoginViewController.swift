//
//  LoginViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation
import LBTATools

class LoginViewController : FormBaseViewController<LoginViewModel>, UITextFieldDelegate {
    
    private let _imageView = UIImageView(image: #imageLiteral(resourceName: "logo_blue_2"), contentMode: .scaleAspectFit)
    
    private let _signInButton = UIButton(title: "", titleColor: UIColor.Theme.white,
                                         font: .systemFont(ofSize: 16), backgroundColor: UIColor.Theme.darkBlue)
    
    private let _signInKeyboardButton = UIButton(title: "", titleColor: UIColor.Theme.white,
                                                 font: .systemFont(ofSize: 16), backgroundColor: UIColor.Theme.darkBlue)
    
    private let _signUpButton = UIButton(title: "", titleColor: UIColor.Theme.darkBlue, font: .systemFont(ofSize: 14))
    
    private let _emailIndicatorLabel = UILabel(text: "", font: .systemFont(ofSize: 11), textColor: UIColor.Theme.white)
    private let _emailTextField = IndentedTextField(keyboardType: .emailAddress)
    private let _emailLineView = UIView(backgroundColor: UIColor.Theme.darkGrey)
    
    private let _passwordIndicatorLabel = UILabel(text: "", font: .systemFont(ofSize: 11), textColor: UIColor.Theme.white)
    private let _passwordTextField = IndentedTextField(isSecureTextEntry: true)
    private let _passwordLineView = UIView(backgroundColor: UIColor.Theme.darkGrey)
                                 
    override public func viewDidLoad() {
        super.viewDidLoad()
        _setUpView()
    }

    private func _setUpView() {
        bottomButtonHeight = 50
        
        _setUpL10NTexts()
        _setupViewSizes()
        _setupTextFields()
        _setupButtons()
        _addViewsToFormStackContainer()
        
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_handleTapDismiss)))
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func _setUpL10NTexts() {
        _signInButton.setTitle(viewModel.signinText, for: .normal)
        _signInKeyboardButton.setTitle(viewModel.signinText, for: .normal)
        _signUpButton.setTitle(viewModel.firstTimeText, for: .normal)
        _emailIndicatorLabel.text = viewModel.emailText
        _passwordIndicatorLabel.text = viewModel.passwordText
    }
    
    private func _setupViewSizes() {
         _imageView.constrainHeight(74)
         
         _signInKeyboardButton.constrainHeight(bottomButtonHeight)

         [_emailLineView,
         _passwordLineView].forEach{$0.constrainHeight(1)}
     }
    
    private func _setupTextFields() {
        _emailTextField.tag = 0
        _passwordTextField.tag = 1
        
        UITextFieldExtensions.setupField(
            indicatorText: viewModel.emailText, indicatorLabel: _emailIndicatorLabel,
            textField: _emailTextField, divider: _emailLineView, returnKeyType: .next,
            activeColor: UIColor.Theme.darkBlue, inactiveColor: UIColor.Theme.darkGrey)
        
        
        UITextFieldExtensions.setupField(
            indicatorText: viewModel.passwordText, indicatorLabel: _passwordIndicatorLabel,
            textField: _passwordTextField, divider: _passwordLineView, returnKeyType: .done,
            activeColor: UIColor.Theme.darkBlue, inactiveColor: UIColor.Theme.darkGrey)
        
        [ _emailTextField,
          _passwordTextField
        ].forEach {
            $0.delegate = self
            $0.textContentType = .oneTimeCode
            $0.autocorrectionType = .no
            $0.inputAccessoryView = _signInKeyboardButton
            $0.constrainHeight(32)
        }
        
        viewModel.email.addObserver(self) {
            self._emailTextField.text = self.viewModel.email.value
        }
    }
    
    private func _setupButtons() {
        self.view.addSubview(_signInButton)
        
        _signInButton.translatesAutoresizingMaskIntoConstraints = false
        _signInButton.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        _signInButton.constrainHeight(bottomButtonHeight + Utils().keyWindow.safeAreaInsets.bottom)
        _signInButton.addTarget(self, action: #selector(_loginAccount), for: UIControl.Event.touchUpInside)
        _signInKeyboardButton.addTarget(self, action: #selector(_loginAccount), for: UIControl.Event.touchUpInside)
        _signUpButton.addTarget(self, action: #selector(_navigateToCreateAccount), for: UIControl.Event.touchUpInside)
    }
    
    private func _addViewsToFormStackContainer(){
        formContainerStackView.stack(
            UIView().stack(_imageView).padBottom(45),
            UIView().stack(_emailIndicatorLabel, _emailTextField, _emailLineView),
            UIView().stack(_passwordIndicatorLabel, _passwordTextField, _passwordLineView),
            UIView().stack(_signUpButton).padTop(35).padBottom(80),
            spacing: 16
        ).withMargins(.init(top: 50, left: 30, bottom: 16, right: 30))
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        let indicatorLabel = _getIndicatorLabel(textField)
        let lineView = _getLineView(textField)
        UITextFieldExtensions.changeFormColors(lineView, indicatorLabel, UIColor.Theme.darkBlue)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let indicatorLabel = _getIndicatorLabel(textField)
        UITextFieldExtensions.animateIndicatorText(textField, string, indicatorLabel)
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let indicatorLabel = _getIndicatorLabel(textField)
        let lineView = _getLineView(textField)
        UITextFieldExtensions.animateFormOnFinishEditing(textField, indicatorLabel, lineView, UIColor.Theme.darkGrey)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.tag == 0 ? _passwordTextField.becomeFirstResponder() : _passwordTextField.resignFirstResponder()
    }
    
    private func _getIndicatorLabel(_ textField: UITextField) -> UILabel {
        return textField.tag == 0 ? _emailIndicatorLabel : _passwordIndicatorLabel
    }
    
    private func _getLineView(_ textField: UITextField) -> UIView {
        return textField.tag == 0 ? _emailLineView : _passwordLineView
    }
    
    @objc fileprivate func _loginAccount(sender: UIButton) {
        viewModel.loginCommand.executeIf([_emailTextField.text!, _passwordTextField.text!])
    }
    
    @objc fileprivate func _navigateToCreateAccount(sender: UIButton) {
        viewModel.navigateToCreateAccountCommand.executeIf()
    }
    
    @objc fileprivate func _handleTapDismiss() {
        view.endEditing(true)
    }
}
