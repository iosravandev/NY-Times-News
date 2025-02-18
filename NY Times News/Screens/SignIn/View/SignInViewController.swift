//
//  SingInVC.swift
//  NewYork Times News
//
//  Created by Ravan on 18.11.24.
//

import UIKit
import Foundation
import FirebaseAuth

class SignInViewController: UIViewController {
    // MARK: - ViewModel
    
    private var viewModel = SignInViewModel()
    
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
        label.text = "Login"
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        let fullText = "Not a member? Sign up"
        let attributedText = NSMutableAttributedString(string: fullText)
        let signUpRange = (fullText as NSString).range(of: "Sign up")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: signUpRange)
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: signUpRange)
        label.attributedText = attributedText
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var emailTextField: InputCustomView = {
        let view = InputCustomView(inputType: .email)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Enter email"
        view.delegate = self
        return view
    }()
    
    private lazy var passwordTextField: InputCustomView = {
        let view = InputCustomView(inputType: .password)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        button.layer.shadowRadius = 4
        button.layer.cornerRadius = 16
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var textFieldSV: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 32
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(pageTitleLabel)
        contentView.addSubview(textFieldSV)
        contentView.addSubview(signInButton)
        contentView.addSubview(signUpLabel)
        
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
            
            signInButton.topAnchor.constraint(equalTo: textFieldSV.bottomAnchor, constant: 36),
            signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 24),
            signUpLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            signUpLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            signUpLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -36)
            
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func bindViewModel() {
        viewModel.onStateChanged = { [weak self] in
            guard let self = self else { return }
            self.signInButton.isEnabled = self.viewModel.isSignInEnabled
            self.signInButton.backgroundColor = self.viewModel.isSignInEnabled ? UIColor.red : UIColor.red.withAlphaComponent(0.5)
        }
        
        viewModel.onSignInSuccess = { [weak self] in
            guard let self = self else { return }
            let tabBarController = TabBarViewController()
            if let window = self.view.window {
                window.rootViewController = UINavigationController(rootViewController: tabBarController)
                window.makeKeyAndVisible()
            } else {
                print("Error: Unable to access window from SignInVC")
            }
        }
        
        
        viewModel.onSignInFailure = { [weak self] error in
            guard let self = self else { return }
            let alert = UIAlertController(title: "sign in failed", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            print("user signin failed: \(error.localizedDescription)")
        }
        
    }
    
    // MARK: - Actions
    
    @objc private func signInButtonTapped() {
        viewModel.signIn(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @objc private func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel else { return }

        // Get the tap location inside the label
        let tapLocation = gesture.location(in: label)

        // Assuming you have a function to get the start and end points of the target text
        let targetText = "Sign up"
        let startEndPoints = label.getStartEndPoints(text: targetText)

        // Check if the tap location is within the bounds of the "Sign up" text
        if tapLocation.x >= startEndPoints.start && tapLocation.x <= startEndPoints.end {
            // Get the SignUpVC from the Router
            let signUpVC = Router.getSignUpVC()
            signUpVC.modalPresentationStyle = .fullScreen
            
            // Present the SignUpVC modally from the current view controller (SignInVC)
            self.present(signUpVC, animated: true, completion: nil)
        }
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

extension SignInViewController: InputCustomViewDelegate {
    func didTapRightIcon() {}
    
    func didChangeTextFieldContent(_ inputCustomView: InputCustomView) {
        viewModel.updateState(email: emailTextField.text, password: passwordTextField.text)
    }
}

