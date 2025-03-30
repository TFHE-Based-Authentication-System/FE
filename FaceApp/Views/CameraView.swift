//
//  CameraView.swift
//  FaceApp
//
//  Created by 강민영 on 3/31/25.
//


import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}
