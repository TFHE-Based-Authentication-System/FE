import SwiftUI

struct MainView: View {
    @State private var showSidebar = false
    @State private var showLogin = false
    @State private var showSignUp = false
    @State private var isLoggedIn = true
    @StateObject var authService = AuthService.shared
    @State private var showCamera = false
    @StateObject var permissionManager = PermissionManager()



    var body: some View {
        ZStack(alignment: .trailing) {
            // 메인화면
            VStack {
                if authService.isLoggedIn{
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
                    Text("FaceApp 메인화면")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                else{
                    Spacer()
                    Image(systemName: "faceid")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                        .padding()
                        .onTapGesture {
                            permissionManager.checkCameraPermission()
                            if permissionManager.isCameraAuthorized {
                                showCamera = true
                            }
                        }
                    
                    Text("FaceApp")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("AI 얼굴 인증 서비스")
                        .foregroundColor(.gray)
                        .font(.subheadline)

            
                    Button(action: {
                        withAnimation {
                            showLogin = true
                            }
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
                    
                    
                    Button(action: {
                        withAnimation {
                             showSignUp = true
                        }
                      }) {
                          Text("회원가입")
                             .foregroundColor(.blue)
                              .padding(.top, 10)
                                        }
                    Spacer()
                    }
                    
                    
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

                  SideMenuView(showMenu: $showSidebar, showLogin: $showLogin, showSignUp: $showSignUp,isLoggedIn: $isLoggedIn)
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
                LoginView(isLoggedIn: $isLoggedIn,showSignUp: $showSignUp)
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
        .sheet(isPresented: $showCamera) {
                   CameraView()
               }
    }
}
#Preview{
    MainView()
}
