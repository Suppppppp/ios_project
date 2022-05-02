//
//  CustomColorPicker.swift
//  try2
//
//  Created by KYUNGSUP GO on 2022/04/23.
//

import SwiftUI
import PhotosUI




// MARK: - 이미지 컬러 피커 불러오는 extension 만들기
extension View {
    func imageColorPicker(showPicker: Binding<Bool>,color: Binding<Color>)->some View{
        return self
            .fullScreenCover(isPresented: showPicker ){
    
            } content: {
                Helper(showPicker: showPicker, color: color)

            }
}
}

// MARK: - Color picker에 대한 커스텀 뷰
struct Helper: View{
    // MARK: - 카메라 변수 윗닫기
    @State private var isShown: Bool = false
    @State private var image : Image = Image(systemName: "photo.on.rectangle.angled")
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    // MARK: - 카메라변수 아래닫기
    
    
    @Binding var showPicker: Bool
    @Binding var color: Color
    
//    Image Pickr 값
    @State var showImagePicker: Bool = false
    @State var imageData: Data = .init(count:0)
    
    
    var body: some View{
        
        NavigationView{
            
            VStack(spacing:10){
                // MARK: - 이미지 picker 뷰 만들기
                GeometryReader{ proxy in
                    
                    let size = proxy.size
                    
                    VStack(spacing: 10){
//                        yogi (이미지 피커에서 이미지 선택)
                        if let seletedImage = UIImage(data: imageData){
//                            선택이 되었다면 이미지 표시
                            Image(uiImage: seletedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width, height: size.height)
                        } else{
                            Image(systemName: "photo.fill.on.rectangle.fill")
                                .font(.system(size: 80))
                            Text("Tap")
                                .font(.system(size: 14, weight: .light))
                        }
                    }
                    .frame(maxWidth: .infinity , maxHeight: .infinity, alignment: .center)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        //Show Image Picker
                        showImagePicker.toggle()
                        
                    }
                    // camera에 대한 액션과 촬영물 담는 거
                    image.resizable().frame(width: 300, height: 200)
                    Button(action: {
                        
                        self.sourceType = .camera
                        self.isShown.toggle()
                        
                    }) {
                        Text("camera")
                    }.sheet(isPresented: $isShown){
                        AceessCamera(isShown : $isShown, myimage: $image, mysourceType: $sourceType)
                    }
                    
                }
                
                Text("RGB value: \( UIColor(color) ) ")
                Text("RFB :  \(UIColor.init(color))")
                

                 
                
                ZStack(alignment: .top){
                    
//                    선택 색상 표시하기
//                    circle, rectangle 원하는 대로 다 표시하기
//                    Circle()
                    Rectangle()
                        .fill(color)
                        .frame(height:100 )
                        .offset(x: -200)
//                    Divider()
                    
                    //                막 grid,Spectrum,Slider이런거 필요없이
                    //                스포이드만 필요하기 때문에 스포이드 외에는 제거할 거임
                                    CustomColorPicker(color: $color)
                    //                위에스포이드만 남기기 위해서 간단한게 picker 높이 50
                    //                남은 content cliping하면
                    //                top bar만 나타날거임
                    //                그다음 스포이드 크기랑 가운데  맞춰주기
                                        .frame(width: 100, height:50, alignment: .topLeading)
                                        .clipped()
                                        .offset(x: -100)
                }
                
                

            }
            .ignoresSafeArea(.container, edges: .bottom)
            .navigationTitle("Image Color Picker")
            .navigationBarTitleDisplayMode(.inline)
        // MARK: - 닫기 버튼
            .toolbar{
                Button("Close"){
                    showPicker.toggle()
                }
            }
            .sheet(isPresented: $showImagePicker) {
            
            } content: {
                ImagePicker(showPicker: $showImagePicker, imageData: $imageData)
            }
    }
    }
}

// MARK: - PhotosUI API로 이미지 피커 구성하기
struct ImagePicker: UIViewControllerRepresentable{
    
    @Binding var showPicker: Bool
    @Binding var imageData: Data
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController{
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config )
        picker.delegate = context.coordinator
        
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController , context: Context) {
        
    }
//        선택한 이미지 가져오기
        class Coordinator: NSObject,PHPickerViewControllerDelegate{
            
            var parent: ImagePicker
            init(parent: ImagePicker){
                self.parent = parent
            }
            
            func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                
//                1개 이미지만 가져오는 제한 걸어놔서 첫번째 이미지가 가져올이미지
                if let first = results.first{
                    
                    first.itemProvider.loadObject(ofClass: UIImage.self) {[self]
                        result, err in guard let image = result as? UIImage else {
                            parent.showPicker.toggle()
                            return
                        }
                        
//                        parent.imageData = image.jpegData( compressionQuality: 1) ?? .init(count: 0)
                        parent.imageData = image.jpegData(compressionQuality: 1) ?? .init(count: 0)
//                        피커로  이미지 선택 후 닫아주기 (선택에 대한 구현은 다른곳 yogi라고 표시한곳)
                        parent.showPicker.toggle()
                    }
                    
                } else{
                    parent.showPicker.toggle()
                }
                
                
            }
        }
}






// MARK: - color picker 커스텀하기 (UIColorPicker도움받아서)
struct CustomColorPicker: UIViewControllerRepresentable{
    
    // MARK: - Picker vlaues
    @Binding var color: Color
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
   
    
    
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = false
        picker.selectedColor = UIColor(color)
        // MARK: - Connecting Delegate
        picker.delegate = context.coordinator
        
        // 스포이드 옆에 자동으로 color라고 나오는 거 지워주기
        picker.title = ""
        return picker
        
        
    }
    
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {
        // 동일색일 때 스포이드 안가려주게하는 extension
        uiViewController.view.tintColor  = (color.isDarkColor ? .white : .black)
        
    }
    // MARK: - delegate  Methods
    class Coordinator: NSObject,UIColorPickerViewControllerDelegate{
        
        var parent: CustomColorPicker
        
        init(parent: CustomColorPicker){
            self.parent = parent
            
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            // MARK: - Updatinf Color
            parent.color = Color(viewController.selectedColor)
        }
        
        func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
            parent.color = Color(color)
        }
    }
    
    
}


// 컬러 찍는 스포이드와 색상이 동일할 때 가려지는 걸 방지하기 위해 동일 색이면 자동으로 다른색 으로 변환되는 코드
extension Color{
    
    var isDarkColor: Bool{
        return UIColor(self).isDarkColor
    }
    
}


extension UIColor{
    
    var isDarkColor: Bool{
        var (r,g,b,a): (CGFloat,CGFloat,CGFloat,CGFloat) = (0,0,0,0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return lum < 0.5

}

}




