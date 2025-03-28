import SwiftUI

struct MainView: View {
    @State private var showSidebar = false
    @State private var showLogin = false
    @State private var showSignUp = false
    @State private var isLoggedIn = false

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
                
                Spacer()

                                VStack(spacing: 16) {
                                    Image(systemName: "faceid")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.blue)
                                        .padding()

                                    Text("FaceApp")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)

                                    Text("AI 얼굴 인증 서비스")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)

                                    if isLoggedIn {
                                        Text("환영합니다 😊")
                                            .font(.headline)
                                            .padding(.top, 10)
                                    } else {
                                        Button(action: {
                                            
                                        }) {
                                            Text("로그인하고 시작하기")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .padding()
                                                .frame(width: 240)
                                                .background(Color.blue)
                                                .cornerRadius(10)
                                                .shadow(radius: 2)
                                        }
                                        .padding(.top, 20)
                                    }
                                }

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

                  SideMenuView(showMenu: $showSidebar, showLogin: $showLogin, showSignUp: $showSignUp)
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
            if showSignUp {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showSignUp = false
                        }
                    }
                SignUpView()
                    .transition(.move(edge: .bottom))
                    .gesture(
                                DragGesture()
                                    .onEnded { value in
                                        if value.translation.height > 100 {
                                            withAnimation {
                                                showSignUp = false
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
