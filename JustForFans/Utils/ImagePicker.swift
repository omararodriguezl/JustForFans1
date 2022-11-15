//
//  ImagePicker.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/21/22.
//

import SwiftUI
import Photos

struct ImagePicker : UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var urlVideo: String?
    @Environment (\.presentationMode) var mode
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        return picker
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    class Coordinator: NSObject , UINavigationControllerDelegate , UIImagePickerControllerDelegate {
        let parent : ImagePicker
        
        init(_ parent: ImagePicker){
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if  info[.mediaType] as! String == "public.movie"{
//                PHPhotoLibrary.requestAuthorization{ status in
//                    switch status {
//                    case .authorized:
//                        self.parent.urlVideo = "\(info[.mediaURL])"
//                        self.parent.mode.wrappedValue.dismiss()
//                    default:
//                        break
//                    }
//                }
//            }
            guard let image = info[.originalImage] as? UIImage else { return }
            self.parent.image = image
            self.parent.mode.wrappedValue.dismiss()
        }
    }
}
