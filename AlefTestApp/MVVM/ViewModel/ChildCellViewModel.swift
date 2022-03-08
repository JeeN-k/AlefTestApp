//
//  ChildCellViewModel.swift
//  AlefTestApp
//
//  Created by Oleg Stepanov on 07.03.2022.
//

import Foundation

protocol ChildCellProtocol {
    var personalData: Observable<PersonalData> { get }
    var cellIndex: Int { get }
    var editDelegate: EditChildDelegate? { get set }
    func removeChild()
    func editName(newValue: String)
    func editAge(newValue: String)
}

protocol EditChildDelegate {
    func removeChild(at index: Int)
    func editName(at index: Int, newValue: String)
    func editAge(at index: Int, newValue: String)
}

class ChildCellViewModel: ChildCellProtocol {
    var editDelegate: EditChildDelegate?
    var cellIndex: Int
    var personalData: Observable<PersonalData>
    
    init(cellIndex: Int, childData: PersonalData) {
        self.cellIndex = cellIndex
        self.personalData = Observable(childData)
    }
    
    func removeChild() {
        guard let editDelegate = editDelegate else { return }
        editDelegate.removeChild(at: cellIndex)
    }
    
    func editName(newValue: String) {
        guard let editDelegate = editDelegate else { return }
        personalData.value.name = newValue
        editDelegate.editName(at: cellIndex, newValue: newValue)
    }
    
    func editAge(newValue: String) {
        guard let editDelegate = editDelegate else { return }
        personalData.value.age = newValue
        editDelegate.editAge(at: cellIndex, newValue: newValue)
    }
    
}
