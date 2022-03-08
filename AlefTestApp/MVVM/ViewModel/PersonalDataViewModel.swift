//
//  PersonalDataViewModel.swift
//  AlefTestApp
//
//  Created by Oleg Stepanov on 07.03.2022.
//

import Foundation

protocol PersonalDataProtocol: EditChildDelegate {
    var children: Observable<[PersonalData]> { get }
    func addNewChild(name: String, age: String)
    func clearFields()
}

class PersonalDataViewModel: PersonalDataProtocol {
    var children: Observable<[PersonalData]> = Observable([])
    
    func addNewChild(name: String, age: String) {
        let newChild = PersonalData(name: name, age: age)
        children.value.append(newChild)
    }
    
    func clearFields() {
        children.value.removeAll()
    }
    
    func removeChild(at index: Int) {
        children.value.remove(at: index)
    }
    
    func editName(at index: Int, newValue: String) {
        let isIndexValid = children.value.indices.contains(index)
        if isIndexValid {
            children.value[index].name = newValue
        }
    }
    
    func editAge(at index: Int, newValue: String) {
        let isIndexValid = children.value.indices.contains(index)
        if isIndexValid {
            children.value[index].age = newValue
        }
    }
}
