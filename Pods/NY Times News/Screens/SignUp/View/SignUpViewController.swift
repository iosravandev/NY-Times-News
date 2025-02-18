//
// SignUpVC.swift
// NewYork Times News
//
// Created by Ravan on 18.11.24.
//
//

import UIKit
import Foundation
import FirebaseAuth

class SignUpViewController: UIViewController {

    private let viewModel = SignUpViewModel()
    
    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        let fullText = "Already a member? Sign in"
        let attributedText = NSMutableAttributedString(string: fullText)
        let signInRange = (fullText as NSString).range(of: "Sign in")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: signInRange)
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: signInRange)
        label.attributedText = attributedText
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var nameTextField: InputCustomView = {
        let view = InputCustomView(inputType: .simple)
        view.placeholder = "Enter name"
        view.delegate = self
        return view
    }()
    
    private lazy var surnameTextField: InputCustomView = {
        let view = InputCustomView(inputType: .simple)
        view.placeholder = "Enter surname"
        view.delegate = self
        return view
    }()
    
    private lazy var emailTextField: InputCustomView = {
        let view = InputCustomView(inputType: .email)
        view.placeholder = "Enter email"
        view.delegate = self
        return view
    }()
    
    private lazy var passwordTextField: InputCustomView = {
        let view = InputCustomView(inputType: .password)
        view.placeholder = "Enter password"
        view.delegate = self
        return view
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.shadowRadius = 4
        button.layer.cornerRadius = 16
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var textFieldSV: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTextField, surnameTextField, emailTextField, passwordTextField])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 32
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(pageTitleLabel)
        contentView.addSubview(textFieldSV)
        contentView.addSubview(signUpButton)
        contentView.addSubview(signInLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            pageTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            pageTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            pageTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            textFieldSV.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 36),
            textFieldSV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            textFieldSV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            signUpButton.topAnchor.constraint(equalTo: textFieldSV.bottomAnchor, constant: 36),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            signInLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 24),
            signInLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            signInLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            signInLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -36)
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @objc private func signUpButtonTapped() {
        guard let name = nameTextField.text, let surname = surnameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, !name.isEmpty, !surname.isEmpty, !email.isEmpty, !password.isEmpty else {
            print("Please fill in all fields.")
            return
        }
        viewModel.updateState(name: name, surname: surname, email: email, password: password)
        viewModel.signUp()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

extension SignUpViewController: InputCustomViewDelegate {
    func didTapRightIcon() {
        // Handle right icon tap if needed
    }
    
    func didChangeTextFieldContent(_ inputCustomView: InputCustomView) {
        viewModel.updateState(name: nameTextField.text, surname: surnameTextField.text, email: emailTextField.text, password: passwordTextField.text)
        let allFieldsFilled = viewModel.fieldsAreValid()
        signUpButton.isEnabled = allFieldsFilled
        signUpButton.backgroundColor = allFieldsFilled ? UIColor.red : UIColor.red.withAlphaComponent(0.5)
    }
}
