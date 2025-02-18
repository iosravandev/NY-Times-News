//
//  InputCustomView.swift
//  NewYork Times News
//
//  Created by Ravan on 18.11.24.
//

import UIKit
import Foundation

protocol InputCustomViewDelegate: AnyObject {
    func didTapRightIcon()
    func didChangeTextFieldContent(_ inputCustomView: InputCustomView)
}

class InputCustomView: UIView {
    
    enum InputType {
        case simple // for name&surname and simple "String" data
        case email // for e-mail
        case password // secured text and rightView with image of eye (isSecured or not)
    }
    
    weak var delegate: InputCustomViewDelegate?
    
    var text: String? {
        return textField.text
    }
    
    var placeholder: String? {
        get {
            textField.placeholder
        } set {
            textField.placeholder = newValue
        }
    }
    
    var isFilled: Bool {
        return !(textField.text?.isEmpty ?? true)
    }
    
    private var textField: UITextField
    private var toggleButton: UIButton?
    
    private var dashView: UIView = {
        let dash = UIView()
        dash.backgroundColor = .gray
        dash.translatesAutoresizingMaskIntoConstraints = false
        return dash
    }()
    
    init(inputType: InputType) {
        textField = UITextField()
        super.init(frame: .zero)
        
        setupTextField()
        configure(for: inputType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        addSubview(textField)
        addSubview(dashView)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            dashView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 3),
            dashView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            dashView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            dashView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dashView.heightAnchor.constraint(equalToConstant: 1)
            
        ])
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    private func configure(for type: InputType) {
        
        switch type {
        case .simple:
            textField.placeholder = "Enter smth"
            textField.keyboardType = .default
        case .email:
            textField.placeholder = "Enter email address"
            textField.keyboardType = .emailAddress
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
        case .password:
            textField.placeholder = "Enter password"
            textField.isSecureTextEntry = true
            textField.rightViewMode = .always
            addToggleButton()
        }
        
    }
    
    private func addToggleButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        toggleButton = button
        textField.rightView = toggleButton
        textField.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        toggleButton?.isSelected = textField.isSecureTextEntry
        delegate?.didTapRightIcon()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        setDashColor()
        delegate?.didChangeTextFieldContent(self)
    }
    
    private func setDashColor() {
        dashView.backgroundColor = isFilled ? .red : .gray
    }
    
}

extension InputCustomView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dashView.backgroundColor = .red
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        setDashColor()
    }
    
}


