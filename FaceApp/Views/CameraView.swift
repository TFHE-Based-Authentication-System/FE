import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var isRegistering: Bool

    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController()
        controller.isRegistering = isRegistering
        controller.modalPresentationStyle = .fullScreen
        return controller
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}
