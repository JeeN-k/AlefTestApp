//
//  TitleView.swift
//  AlefTestApp
//
//  Created by Oleg Stepanov on 07.03.2022.
//

import Foundation
import UIKit

class TitleView: UIView {
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Персональные данные"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Возраст"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.backgroundColor = .systemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleView {
    private func configureConstraints() {
        addSubview(titleLable)
        addSubview(nameTextField)
        addSubview(ageTextField)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: topAnchor),
            titleLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLable.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            ageTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ageTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ageTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
