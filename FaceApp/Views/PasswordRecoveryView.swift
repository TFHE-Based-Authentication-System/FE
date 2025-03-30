//
//  PasswordRecoveryView.swift
//  FaceApp
//
//  Created by 강민영 on 3/30/25.
//


import SwiftUI

struct PasswordRecoveryView: View {
    @State private var email: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("비밀번호 찾기")
                .font(.title)
                .bold()
                .padding(.top, 50)

            TextField("가입한 이메일을 입력하세요", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 30)

            Button(action: {
                print("비밀번호 찾기 요청 - 이메일: \(email)")
            }) {
                Text("비밀번호 찾기")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
            }

            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    PasswordRecoveryView()
}
