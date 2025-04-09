import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var isLoggedIn: Bool
    @Binding var showSignUp: Bool
    @State private var showPasswordRecovery = false
    @ObservedObject var authService = AuthService.shared


    var body: some View {
        VStack {
            Spacer().frame(height: 200)
            Text("Login")
                .padding()
                .font(.largeTitle)
                .bold()

            VStack(spacing: 16) {
                TextField("이메일을 입력하세요", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)

                SecureField("비밀번호를 입력하세요", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)

            Button(action: {
                print("로그인 시도 - 이메일: \(email), 비밀번호: \(password)")
                AuthService.shared.login(email: email, password: password)
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

            HStack {
                Button("비밀번호 찾기") {
                    withAnimation {
                        showPasswordRecovery = true
                    }
                }
                Spacer()
                Button("회원가입") {
                    withAnimation {
                        showSignUp = true
                    }
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
        .sheet(isPresented: $showPasswordRecovery) {
            PasswordRecoveryView()
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false), showSignUp: .constant(false))
}
