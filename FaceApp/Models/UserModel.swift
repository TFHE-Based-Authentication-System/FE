//
//  UserModel.swift
//  FaceApp
//
//  Created by 강민영 on 3/28/25.
//

import Foundation

final class UserModel {
    struct User {
        var email: String
        var password: String
    }
    
    // 이메일 형식 검사
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // 비밀번호 형식 검사 (영문/숫자 8자 이상)
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
}
