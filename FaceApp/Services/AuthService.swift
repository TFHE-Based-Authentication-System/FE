import Foundation
import Combine

final class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @Published var isLoggedIn: Bool = false
    
    private let baseURL = "http://서버주소/api/user" // 🔥 백엔드가 준 주소에 맞게 수정
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
    
    // MARK: - 로그인
    func login(email: String, password: String) {
        guard let url = URL(string: "\(baseURL)/login") else { return }
        let body: [String: String] = ["email": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
    
    // MARK: - 회원가입
    func signUp(email: String, password: String) {
        guard let url = URL(string: "\(baseURL)/signup") else { return }
        let body: [String: String] = ["email": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
    
    // MARK: - 로그아웃
    func logout() {
        isLoggedIn = false
        print("🚪 로그아웃 완료")
    }
}

// MARK: - 공통 Response
struct AuthResponse: Codable {
    let message: String
}
