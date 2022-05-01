//
//  CameraAlbum.swift
//  AddPicker
//
//  Created by KYUNGSUP GO on 2022/04/24.
//

import Foundation
import SwiftUI
import UIKit

struct AceessCamera : UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var myimage : Image
    @Binding var mysourceType : UIImagePickerController.SourceType
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<AceessCamera>) {

    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AceessCamera>) -> UIImagePickerController {
        
        
        let obj  = UIImagePickerController()
        obj.sourceType = mysourceType
        obj.delegate = context.coordinator
        return obj
    }
    
    
    func makeCoordinator() -> C {
        return C(isShown: $isShown, myimage: $myimage)
    }
    
}


class C: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @Binding var isShown: Bool
    @Binding var myimage: Image
    
    init(isShown: Binding<Bool>, myimage: Binding<Image>) {
        _isShown = isShown
        _myimage = myimage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(image)
            myimage = Image.init(uiImage: image)
            
        }
        isShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
    
}

