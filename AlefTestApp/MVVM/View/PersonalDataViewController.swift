//
//  ViewController.swift
//  AlefTestApp
//
//  Created by Oleg Stepanov on 07.03.2022.
//

import UIKit

class PersonalDataViewController: UIViewController {
    
    private var tableView = UITableView()
    private var titleView = TitleView(frame: .zero)
    private lazy var childLabel: UILabel = {
        let label = UILabel()
        label.text = "Дети (макс. 5)"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var newChildButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить ребенка", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.addTarget(self, action: #selector(newChildTaped), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.addTarget(self, action: #selector(clearFields), for: .touchUpInside)
        return button
    }()
    
    var viewModel: PersonalDataProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PersonalDataViewModel()
        configureView()
        configureTable()
        viewModel.children.bind { _ in
            self.reloadView()
        }
    }
    
    private func reloadView() {
        tableView.reloadData()
        
        if viewModel.children.value.count >= 5 {
            newChildButton.isHidden = true
        } else {
            newChildButton.isHidden = false
        }
        
        if viewModel.children.value.count == 0 {
            clearButton.isHidden = true
        } else {
            clearButton.isHidden = false
        }
    }
    
    @objc
    private func newChildTaped() {
        viewModel.addNewChild(name: "", age: "")
    }
    
    @objc
    private func clearFields() {
        titleView.nameTextField.text = ""
        titleView.ageTextField.text = ""
        viewModel.clearFields()
    }
}

extension PersonalDataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.children.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChildCellView
        guard let cell = cell else { return UITableViewCell() }
        cell.viewModel = ChildCellViewModel(cellIndex: indexPath.row, childData: viewModel.children.value[indexPath.row])
        cell.listenObserver()
        cell.viewModel.editDelegate = viewModel
        return cell
    }
}

extension PersonalDataViewController {
    
    private func configureView() {
        view.addSubview(tableView)
        view.addSubview(titleView)
        view.addSubview(childLabel)
        view.addSubview(newChildButton)
        view.addSubview(clearButton)
        view.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            childLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
            childLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            childLabel.widthAnchor.constraint(equalToConstant: 160),
            
            newChildButton.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
            newChildButton.leadingAnchor.constraint(equalTo: childLabel.trailingAnchor, constant: 10),
            newChildButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: childLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            clearButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func configureTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.register(ChildCellView.self, forCellReuseIdentifier: "cell")
    }
}

