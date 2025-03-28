import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool
    @Binding var showLogin: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button("로그인") {
                withAnimation {
                    showLogin = true
                    showMenu = false
                }
            }
            .padding(.top, 100)
            .foregroundColor(.black) // 사이드바 배경 색 (기본 흰색)
            .font(.title2)      // 사이드바 너비 설정
            
            Spacer()
        }
        .padding()
        .frame(width: 130)
        .background(Color.white)
        .shadow(color: .gray.opacity(0.2), radius: 3, x: 1, y: 0)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SideMenuView(showMenu: .constant(true), showLogin: .constant(false))
}
