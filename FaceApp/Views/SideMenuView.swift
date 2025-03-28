import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool
    @Binding var showLogin: Bool
    @Binding var showSignUp: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button("로그인") {
                withAnimation {
                    showLogin = true
                    showMenu = false
                }
            }
            .padding()
            
            Button("회원가입"){
                withAnimation {
                    showSignUp = true
                    showMenu = false
                }
            }
            
            Spacer()
        }
        .padding(.top, 100)
        .padding(.leading, 20)
        .foregroundColor(.black) // 사이드바 배경 색 (기본 흰색)
        .font(.title2)      // 사이드바 너비 설정
        .frame(width: 130)
        .background(Color.white)
        .shadow(color: .gray.opacity(0.2), radius: 3, x: 1, y: 0)
        .edgesIgnoringSafeArea(.all)
    }
}

