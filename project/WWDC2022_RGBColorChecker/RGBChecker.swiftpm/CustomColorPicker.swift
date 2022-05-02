//
//  CustomColorPicker.swift
//  RGBChecker
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

// MARK: - Custom View for Color picker
struct Helper: View{


    @Binding var showPicker: Bool
    @Binding var color: Color
    
//    Image Pickr variable
    @State var showImagePicker: Bool = false
    @State var imageData: Data = .init(count:0)
    


    var body: some View{
        
        NavigationView{

            VStack(spacing:10){
                // MARK: - Make Image Picker View
                GeometryReader{ proxy in
                    
                    let size = proxy.size
                    
                    VStack(spacing: 10){
//                        Get Image on Image Picker # mark
                        if let seletedImage = UIImage(data: imageData){
//                            If selected Image , display Image
                            Image(uiImage: seletedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width, height: size.height)
                        } else{
                            VStack{
                                Image("galleryImage")
                                    .resizable()
                                    .frame(width: 150, height: 150, alignment: .center)
                                Text("Gallery").fontWeight(.bold)
                                    .font(.system(size: 15))
                                    .frame(width: 150, height: 30, alignment: .center)
                                    .foregroundColor(.white)
                                    .overlay(Capsule().stroke(
                                        LinearGradient(gradient:
                                        
                                        Gradient(colors: [
                                            Color(.systemTeal),
                                            Color(.systemPurple),
                                            Color(.systemOrange)
                                        ]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing),
                                    lineWidth: 5
                                    
                                    )
                                    )
                                    .background(.black).cornerRadius(150)
                            }.offset( y: 100)

                                
                        }
                    }
                    .frame(maxWidth: .infinity , maxHeight: 300, alignment: .center)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        //Show Image Picker
                        showImagePicker.toggle()
                        
                    }

                    
                }
                

                HStack{
                    ZStack(alignment: .top){
                        
    //                  selected color display
                        Circle()
                            .fill(color)
                            .frame(height:145 )
                            .offset(x: -10,y: -80)

//                        Remove everything except the pipette
                                        CustomColorPicker(color: $color)
                                            .frame(width: 100, height:50, alignment: .center
                                            )
                                            .clipped()
                                            .offset(x: 10, y: -37)
                        
                    }
                    
                    HStack{
                        
                        VStack{
                            Text("R")
                            Text("G")
                            Text("B")
                            Text("Oapcity")
                            
                        }
                        VStack{
                            Text("                  ").background(LinearGradient(gradient: Gradient(colors: [
                                Color.init(red: UIColor(color).getRGBValues().doubleVal[0] ,
                                           green: 0,
                                           blue: 0),
                                Color.init(red: 1,
                                           green: 1,
                                           blue: 1),
                                Color.init(red: UIColor(color).getRGBValues().doubleVal[0] ,
                                           green: 0,
                                           blue: 0),
                                Color.init(red: 1,
                                           green: 1,
                                           blue: 1),
                                


                            ]), startPoint: .bottomTrailing, endPoint: .topLeading
                            )).clipShape(Capsule())
                            


                            
                            
                            Text("                  ").background(LinearGradient(gradient: Gradient(colors: [
                                Color.init(red: 0,
                                           green:
                                            UIColor(color).getRGBValues().doubleVal[1],
                                           blue: 0),
                                
                                Color.init(red: 1,
                                           green: 1,
                                           blue: 1),
                                
                                Color.init(red: 0,
                                           green:
                                            UIColor(color).getRGBValues().doubleVal[1],
                                           blue: 0),
                                
                                Color.init(red: 1,
                                           green: 1,
                                           blue: 1),

                                



                            ]), startPoint: .bottomTrailing, endPoint: .topLeading
                            )).clipShape(Capsule())
                                

                            
                            
                            Text("                  ").background(LinearGradient(gradient: Gradient(colors: [
                                

                                Color.init(red: 0,
                                           green: 0,
                                           blue: UIColor(color).getRGBValues().doubleVal[2]),
                                
                                Color.init(red: 1,
                                           green: 1,
                                           blue: 1),
                                
                                Color.init(red: 0,
                                           green: 0,
                                           blue: UIColor(color).getRGBValues().doubleVal[2]),
                                
                                Color.init(red: 1,
                                           green: 1,
                                           blue: 1)


                            ]), startPoint: .bottomTrailing, endPoint: .topLeading
                            )).clipShape(Capsule())
                            
                            
                            Text("                  ").background(LinearGradient(gradient: Gradient(colors: [
                                Color.init(red: 0.4,
                                           green: 0.4,
                                           blue: 0.4),

                                Color.init(red: 1,
                                           green: 1,
                                           blue: 1),
                                
                                Color.init(red: 0.4,
                                           green: 0.4,
                                           blue: 0.4),

                                Color.init(red: 1,
                                           green: 1,
                                           blue: 1)
                                



                            ]), startPoint: .bottomTrailing, endPoint: .topLeading
                            )).clipShape(Capsule())
                            
                            
                        }

                        VStack{
                            Text("\(UIColor(color).getRGBValues().strVal[0])")
                            Text("\(UIColor(color).getRGBValues().strVal[1])")
                            Text("\(UIColor(color).getRGBValues().strVal[2])")
                            Text("\(UIColor(color).getRGBValues().strVal[3])")
                            
                        }
                    }.offset(x: -30, y: -80)
                        .foregroundColor(.black)




                     
                }

            
            }
            .ignoresSafeArea(.container, edges: .bottom)
            .navigationTitle("Image Color Picker")
            .navigationBarTitleDisplayMode(.inline)
            .background(.white)
            
        // MARK: - Back buttom
            .toolbar{
                Button("Back"){
                    showPicker.toggle()
                }
                .foregroundColor(.black)
                
            }
            .sheet(isPresented: $showImagePicker) {
            
            } content: {
                ImagePicker(showPicker: $showImagePicker, imageData: $imageData)
            }
    }
    }
}

// MARK: - Configuring the image picker with the PhotosUI API
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
//        Get Seleted Image
        class Coordinator: NSObject,PHPickerViewControllerDelegate{
            
            var parent: ImagePicker
            init(parent: ImagePicker){
                self.parent = parent
            }
            
            func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
//                Only get one Image (The first image)
                if let first = results.first{
                    
                    first.itemProvider.loadObject(ofClass: UIImage.self) {[self]
                        result, err in guard let image = result as? UIImage else {
                            parent.showPicker.toggle()
                            return
                        }
                        

                        parent.imageData = image.jpegData(compressionQuality: 1) ?? .init(count: 0)
//                        Close after selecting an image with the picker  # mark
                        parent.showPicker.toggle()
                    }
                    
                } else{
                    parent.showPicker.toggle()
                }
                
                
            }
        }
}


// MARK: - color picker Custom (with UIColorPicker )
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
        
//        Delete the automatically displayed color next to the pipette

        picker.title = ""
        return picker
        
        
    }
    
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {
//        An extension that doesn't hide the pipette when it's the same color
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





//Code that automatically converts to a different color if the color is the same to prevent being covered when the color is the same as the pipette
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
    public convenience init?(rgbaString : String){
        self.init(ciColor: CIColor(string: rgbaString))
    }
    


//    func to get RGB values ​​Each RGB value is returned as an Array[String] & Array[Double]
    func getRGBValues()-> (strVal : Array<String> ,doubleVal : Array<Double>) {

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        r = round(r * 255)
        let strR = "\(r)"
        g = round(g * 255)
        let strG = "\(g)"
        b = round(b * 255)
        let strB = "\(b)"
        a = round(a * 255)
        let strA = "\(a)"
        
        let colorValueArray : Array<String> = [strR,strG,strB,strA]
        let colorDoubleValueArray : Array<Double> = [r, g, b, a]
        
        return (colorValueArray , colorDoubleValueArray)

    }



}




