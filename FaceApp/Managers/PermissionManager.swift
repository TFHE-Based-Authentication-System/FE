import Foundation
import AVFoundation
import UIKit

class PermissionManager: ObservableObject {
    @Published var isCameraAuthorized = false
    
    // 권한 상태 확인
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isCameraAuthorized = true
        case .notDetermined:
            requestCameraPermission()
        case .denied, .restricted:
            DispatchQueue.main.async {
                self.showAlertGoToSetting()
            }
        @unknown default:
            break
        }
    }
    
    // 권한 요청
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
