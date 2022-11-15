//
//  ImageUploader.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/22/22.
//

import UIKit
import Firebase
import FirebaseStorage

enum UploadType {
    case profile
    case post
    case message
    case channel
    var filePath: StorageReference{
        let filename = NSUUID().uuidString
        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/profile_images/\(filename)")
        case .post:
           return  Storage.storage().reference(withPath: "/post_images/\(filename)")
        case .message:
            return Storage.storage().reference(withPath: "/message_images/\(filename)")
        case .channel:
            return Storage.storage().reference(withPath: "/channel_images/\(filename)")
        }
    }
}

struct ImageUploader {
    static func uploadImage(image: UIImage,type : UploadType ,completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let ref = type.filePath
        ref.putData(imageData, metadata: nil){ _, error in
            if let error = error {
                print("Debug: faild to upload image\(error.localizedDescription)")
                return
            }
            print("SuccessFully uploaded image ...")
            
            ref.downloadURL{ url, _ in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
    static func uploadVideo(url: String,type : UploadType ,completion: @escaping(String) -> Void){
        guard let urlData = URL(string: url) else {return}
        let ref = type.filePath
        let metada = StorageMetadata()
        metada.contentType = "video/quicktime"
        print("Debug: this is filepath", url)
        ref.putFile(from: urlData , metadata: metada){ _, error in
                if let error = error {
                    print("Debug: faild to upload image\(error.localizedDescription)")
                    return
                }
                print("SuccessFully uploaded image ...")
                
                ref.downloadURL{ url, _ in
                    guard let imageUrl = url?.absoluteString else {return}
                    completion(imageUrl)
                }
            }
       
    }
}

