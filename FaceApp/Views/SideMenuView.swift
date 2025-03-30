import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool
    @Binding var showLogin: Bool
    @Binding var showSignUp: Bool
    @Binding var isLoggedIn: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Button("로그아웃") {
                withAnimation {
                    // 상태 초기화
                    showMenu = false
                    showLogin = false
                    showSignUp = false
                    isLoggedIn = false
                }
                AuthService.shared.logout()
            }
            .padding()
            
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

