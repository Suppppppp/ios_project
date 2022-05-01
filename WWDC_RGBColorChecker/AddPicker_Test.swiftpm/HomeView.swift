//
//  ColorPicker.swift
//  pickerTest
//
//  Created by KYUNGSUP GO on 2022/04/23.
//

import SwiftUI

struct HomeView: View {
    @State var showPicker: Bool = false
    @State var selectedColor: Color = .white
    
    var body: some View {
        ZStack{
            
            Rectangle()
//            show Image color picker 버튼 배경색
                .fill(LinearGradient(gradient: Gradient(colors: [
                    Color.black,
                    Color.red,
                    Color.orange,
                    Color.yellow,
                    Color.green,
                    Color.blue,
                    Color.purple,
                    Color.white
                
                
                
                ]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            
            Button{
                showPicker.toggle()
            } label: {
                Text("Show Image Color picker")
                    .foregroundColor(.black)

            }
        
        }
        // MARK: - modifier 불러오기
        .imageColorPicker(showPicker: $showPicker, color: $selectedColor)
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
