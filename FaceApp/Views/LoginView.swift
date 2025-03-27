//
//  LoginView.swift
//  FaceApp
//
//  Created by 강민영 on 3/27/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 24) {
            Text("로그인")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                TextField("이메일을 입력하세요", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("비밀번호를 입력하세요", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }

            Button(action: {
                // 여기에 로그인 API 연동 예정
                print("로그인 시도 - 이메일: \(email), 비밀번호: \(password)")
            }) {
                Text("로그인")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
