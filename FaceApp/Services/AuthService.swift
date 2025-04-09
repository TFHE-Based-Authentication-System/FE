import Foundation
import Combine

// 로그인/회원가입 상태를 관리하는 싱글톤 인증 서비스
final class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @Published var isLoggedIn: Bool = false // 로그인 상태를 뷰에서 관찰 가능하게 함
    
    private let baseURL = "http://3.39.109.122/api/user"    // 서버의 api 주소

    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
    
    // 로그인 함수
    func login(email: String, password: String) {
        // 요청 본문 구성
        guard let url = URL(string: "\(baseURL)/login") else { return }
        let body: [String: String] = ["email": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 서버에 로그인 요청
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: AuthResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("❗️로그인 실패: \(error)")
                    self.isLoggedIn = false
                case .finished:
                    break
                }
            }, receiveValue: { response in
                print("✅ 로그인 성공: \(response.message)")
                self.isLoggedIn = true
            })
            .store(in: &cancellables)
    }
    
    // 회원가입 함수
    func signUp(email: String, password: String) {
        // 요청 본문 구성
        guard let url = URL(string: "\(baseURL)/signup") else { return }
        let body: [String: String] = ["email": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        // 서버에 회원가입 요청
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: AuthResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("❗️회원가입 실패: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { response in
                print("✅ 회원가입 성공: \(response.message)")
            })
            .store(in: &cancellables)
    }
    
    // 로그아웃 함수
    func logout() {
        isLoggedIn = false
        print("🚪 로그아웃 완료")
    }
}

// 공통 Response
struct AuthResponse: Codable {
    let message: String
}
