import SwiftUI

struct SignUpView: View {
    @State private var userId: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 120)
            Text("회원가입")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)

            VStack(spacing: 16) {
                TextField("아이디를 입력하세요", text: $userId)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .autocapitalization(.none)

                SecureField("비밀번호를 입력하세요", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                SecureField("비밀번호 확인", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            Button(action: {
                print("회원가입 시도 - 아이디: \(userId), 비밀번호: \(password)")
                // 여기에 회원가입 API 연동 예정
            }) {
                Text("회원가입")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    SignUpView()
}
