import Foundation
import AVFoundation
import UIKit

// 카메라 권한을 관리하는 매니저 클래스
class PermissionManager: ObservableObject {
    @Published var isCameraAuthorized = false // 카메라 접근 권한 여부를 알려주는 상태 변수
    
    // 현재 카메라의 권한 상태를 확인할 수 있는 함수
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:   // 이미 권한 있으면
            isCameraAuthorized = true
        case .notDetermined:    //권한 없으면 사용자에게 권한 요청
            requestCameraPermission()
        case .denied, .restricted:  //만약 권한 거부면 설정창 가도록 함
            DispatchQueue.main.async {
                self.showAlertGoToSetting()
            }
        @unknown default:
            break
        }
    }
    
    // 권한 요청 함수
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                self.isCameraAuthorized = granted
                if !granted {
                    self.showAlertGoToSetting()
                }
            }
        }
    }
    
    // 권한 거부 → Setting 이동 Alert
    private func showAlertGoToSetting() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else { return }
        
        let alert = UIAlertController(title: "카메라 권한 필요",
                                      message: "FaceApp을 사용하려면 카메라 접근 권한이 필요합니다.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        rootVC.present(alert, animated: true)
    }
}
