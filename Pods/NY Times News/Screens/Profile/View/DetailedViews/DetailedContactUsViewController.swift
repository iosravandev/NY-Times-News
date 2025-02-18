//
//  DetailedContactUsViewController.swift
//  NewYork Times News
//
//  Created by Ravan on 14.12.24.
//

import UIKit
import Foundation

class DetailedContactUsViewController: UIViewController {
    
    private let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "ContactUs"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pageText: UILabel = {
        let text = UILabel()
        text.text = "jajaniefklsdfsjajaniefkssdfsjajaniefklsdfsjajaniefklsdfsjajaniefklsdfsjajaniefklsdfsjajaniefklsdfsjajaniefklsdfs"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.addSubview(pageTitle)
        view.addSubview(pageText)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            pageText.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 16),
            pageText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            pageText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            pageText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)

        ])
        
    }
    
    
}
