//
//  UserModel.swift
//  FaceApp
//
//  Created by 강민영 on 3/28/25.
//

import Foundation

final class UserModel {
    struct User {
        var userId: String
        var password: String
    }
    
    // 아이디 형식 검사 (영문/숫자 4~12자)
    func isValidUserId(id: String) -> Bool {
        let idRegEx = "^[a-zA-Z0-9]{4,12}$"
        let idTest = NSPredicate(format: "SELF MATCHES %@", idRegEx)
        return idTest.evaluate(with: id)
    }
    
    // 비밀번호 형식 검사 (영문/숫자 8자 이상)
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
}
