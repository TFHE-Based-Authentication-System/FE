import SwiftUI

struct LoginView: View {
    @State private var userId: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Spacer()
            Text("Login")
                .padding()
                .font(.largeTitle)
                .bold()
            // 입력 필드
            VStack(spacing: 16) {
                TextField("아이디", text: $userId)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)

                SecureField("비밀번호", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
            
            // 로그인 버튼
            Button(action: {
                print("로그인 시도 - 아이디: \(userId), 비밀번호: \(password)")
            }) {
                Text("로그인")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
            }
            
            // 비밀번호 찾기, 회원가입
            HStack {
                Button("비밀번호 찾기") {
                    // 추후 구현
                }
                Spacer()
                Button("회원가입") {
                    // 추후 구현
                }
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.horizontal, 30)
            .padding(.top, 10)
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView()
}
