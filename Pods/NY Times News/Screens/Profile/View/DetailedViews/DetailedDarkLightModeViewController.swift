//
//  DetailedDarkLightModeViewController.swift
//  NewYork Times News
//
//  Created by Ravan on 14.12.24.
//

import UIKit
import Foundation

class DetailedDarkLightModeViewController: UIViewController {
    
    private let lightModeImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "LightMode"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return image
    }()
    
    private let darkModeImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "DarkMode"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return image
    }()
    
    private lazy var imageStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [lightModeImage, darkModeImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.addSubview(imageStack)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            
            imageStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            imageStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            imageStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            imageStack.heightAnchor.constraint(equalToConstant: 200)
            
        ])
        
    }
    
}
