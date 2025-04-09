// CameraViewController.swift

import UIKit
import AVFoundation

// 얼굴 촬영 및 서버 전송을 담당하는 카메라 컨트롤러
class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    var captureSession: AVCaptureSession!   // 캡처 세선
    var previewLayer: AVCaptureVideoPreviewLayer!   // 카메라 화면 미리보기 레이어
    var photoOutput: AVCapturePhotoOutput!  //사진 캡처 출력을 위한 객체

    // 등록 모드인지 판별 모드인지 여부
    var isRegistering: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()   // 카메라 설정
        addCaptureButton()  // 촬영 버튼
    }

    func setupCamera() {
            captureSession = AVCaptureSession()
            captureSession.sessionPreset = .photo

            // 셀카 카메라로 설정
            guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
                print("전면 카메라를 찾을 수 없습니다.")
                return
            }

            do {
                let input = try AVCaptureDeviceInput(device: frontCamera)
                photoOutput = AVCapturePhotoOutput()

                if captureSession.canAddInput(input) && captureSession.canAddOutput(photoOutput) {
                    captureSession.addInput(input)
                    captureSession.addOutput(photoOutput)
                    setupPreview()  // 카메라 화면 미리보기
                }
            } catch {
                print("카메라 초기화 실패: \(error)")
            }
        }

    // 카메라 미리보기 레이어
    func setupPreview() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)

        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

    // 촬영 버튼
    func addCaptureButton() {
        let button = UIButton(type: .system)
        button.setTitle("촬영", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black.withAlphaComponent(0.5)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }

    // 촬영된 이미지 FastAPI 서버로 전송
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) else { return }

        let base64String = imageData.base64EncodedString()

        // 등록 모드인지 인증 모드인지에 따라 요철 URL 분리해 놓음
        let endpoint = isRegistering ? "/api/image/register" : "/api/image/verify"
        guard let url = URL(string: "http://192.168.200.146:8000" + endpoint) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // JSON 형태로 서버에 전송할 body 구성
        let payload: [String: String] = [
            "image_base64": base64String,
            "user_id": "77" // 등록용일 때만 사용됨
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        
        // 서버로 요청 전송
        URLSession.shared.dataTask(with: request) { data, response, error in
            var resultMessage = "서버 응답 없음"
            
            // 응답 파싱
            if let error = error {
                print("❌ 요청 에러 발생: \(error.localizedDescription)")
                resultMessage = "❌ 요청 실패: \(error.localizedDescription)"
            }

            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let userId = json["user_id"] as? String {
                        resultMessage = "✅ 인증된 사용자: \(userId)"
                    } else if let message = json["message"] as? String {
                        resultMessage = "❌ \(message)"
                    }
                } else if let responseText = String(data: data, encoding: .utf8) {
                    resultMessage = responseText
                }
            }
            
            // 결과 알림창 띄우기
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "얼굴 인증 결과", message: resultMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                    self.dismiss(animated: true)
                })
                self.present(alert, animated: true)
            }
        }.resume()

    }

}
