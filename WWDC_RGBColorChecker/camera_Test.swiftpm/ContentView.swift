import SwiftUI
import UIKit

struct ContentView: View {
    
    
    @State private var isShown: Bool = false
    @State private var image : Image = Image(systemName: "photo.on.rectangle.angled")
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        VStack {

            Button(action: {
                
                self.sourceType = .camera
                self.isShown.toggle()
                
            }) {
                Text("camera")
            }
            image.resizable().frame(width: 300, height: 200)
            Button(action:{
                self.isShown.toggle()
                self.sourceType = .photoLibrary
            }) {
                Text("gallery")
            }
            Button(action: {
                self.isShown.toggle()
                self.sourceType = .savedPhotosAlbum
            }) {
                Text("album")
            }
        }.sheet(isPresented: $isShown){
            AceessCamera(isShown : self.$isShown, myimage: self.$image, mysourceType: self.$sourceType)
        }
    }
}



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

