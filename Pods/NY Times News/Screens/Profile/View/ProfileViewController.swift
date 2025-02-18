//
//  ProfileViewController.swift
//  NewYork Times News
//
//  Created by Ravan on 27.11.24.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private let viewModel = ProfileViewModel()
    
    private lazy var profileTitle: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private lazy var profilePhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 40
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .lightGray
        return image
    }()
    
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileEmailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.isScrollEnabled = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        return tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    private func setupView() {
        
        view.addSubview(profileTitle)
        view.addSubview(profilePhoto)
        view.addSubview(profileNameLabel)
        view.addSubview(profileEmailLabel)
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            profileTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            profilePhoto.topAnchor.constraint(equalTo: profileTitle.bottomAnchor, constant: 36),
            profilePhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profilePhoto.widthAnchor.constraint(equalToConstant: 100),
            profilePhoto.heightAnchor.constraint(equalToConstant: 100),
            
            profileNameLabel.topAnchor.constraint(equalTo: profilePhoto.topAnchor),
            profileNameLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            profileNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            profileEmailLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 4),
            profileEmailLabel.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor),
            profileEmailLabel.trailingAnchor.constraint(equalTo: profileNameLabel.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 36),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupData() {
        
        profileNameLabel.text = viewModel.userName
        profileEmailLabel.text = viewModel.userEmail
        profilePhoto.image = UIImage(systemName: "person.circle")

        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.profileNameLabel.text = self?.viewModel.userName
                self?.profileEmailLabel.text = self?.viewModel.userEmail
            }
        }
    }

    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell
        else { return UITableViewCell() }
        let model = viewModel.items[indexPath.section]
        cell.configureCell(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            Router.pushDetailedAboutViewController(on: self)
        case 1:
            Router.pushDetailedTermsViewController(on: self)
        case 2:
            Router.pushDetailedPrivacyViewController(on: self)
        case 3:
            Router.pushDetailedContactUsViewController(on: self)
        case 4:
            Router.pushDetailedDarkLightModeViewController(on: self)
        default:
            print("Detailed screen not found when in Profilec screen tapped tableview cell")
        }
    }
    
}
