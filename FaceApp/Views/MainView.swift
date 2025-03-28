import SwiftUI

struct MainView: View {
    @State private var showSidebar = false
    @State private var showLogin = false

    var body: some View {
        ZStack(alignment: .trailing) {
            // 메인화면
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showSidebar = true
                        }
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                            .padding()
                    }
                }
                Spacer().frame(height: 10)
                Text("FaceApp 메인화면")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }

            // 옵션바
            if showSidebar {
                  Color.black.opacity(0.3)
                      .ignoresSafeArea()
                      .onTapGesture {
                          withAnimation {
                              showSidebar = false
                          }
                      }

                  SideMenuView(showMenu: $showSidebar, showLogin: $showLogin)
                      .transition(.move(edge: .trailing))
            }

            // 로그인뷰
            if showLogin {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showLogin = false
                        }
                    }
                LoginView()
                    .transition(.move(edge: .bottom))
                    .gesture(
                                DragGesture()
                                    .onEnded { value in
                                        if value.translation.height > 100 {
                                            withAnimation {
                                                showLogin = false
                                            }
                                        }
                                    }
                            )
            }
        }
    }
}
#Preview{
    MainView()
}
