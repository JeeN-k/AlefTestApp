//
//  EnterDataCellView.swift
//  AlefTestApp
//
//  Created by Oleg Stepanov on 07.03.2022.
//

import Foundation
import UIKit

final class ChildCellView: UITableViewCell {
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(nameDidChanged), for: .editingDidEnd)
        return textField
    }()
    
    private lazy var ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Возраст"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(ageDidChanged), for: .editingDidEnd)
        return textField
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(removeChild), for: .touchUpInside)
        return button
    }()
    
    var viewModel: ChildCellProtocol!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func listenObserver() {
        viewModel.personalData.bind { _ in
            self.updateFields()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ageTextField.text = ""
        nameTextField.text = ""
    }
    
    private func updateFields() {
        nameTextField.text = viewModel.personalData.value.name
    }
    
    @objc
    private func removeChild() {
        ageTextField.text = ""
        nameTextField.text = ""
        viewModel.removeChild()
    }
    
    @objc
    private func ageDidChanged() {
        
    }
    
    @objc
    private func nameDidChanged() {
        viewModel.editName(newValue: nameTextField.text ?? "")
    }
}

extension ChildCellView {
    
    private func configureConstraints() {
        contentView.addSubview(nameTextField)
        contentView.addSubview(ageTextField)
        contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            deleteButton.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ageTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
}
