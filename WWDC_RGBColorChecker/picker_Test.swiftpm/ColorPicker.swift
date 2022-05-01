//
//  ColorPicker.swift
//  pickerTest
//
//  Created by KYUNGSUP GO on 2022/04/23.
//

import SwiftUI

struct ColorPicker: View {
    @State var showPicker: Bool = false
    @State var selectedColor: Color = .white
    
    var body: some View {
        ZStack{
            
            Rectangle()
//            show Image color picker 버튼 배경색
//                .fill(.green)
                .fill(selectedColor)
                .ignoresSafeArea()
            
            Button{
                showPicker.toggle()
            } label: {
                Text("Show Image Color picker")
                    .foregroundColor(selectedColor.isDarkColor ? .white : .black)
            }
        
        }
        // MARK: - modifier 불러오기
        .imageColorPicker(showPicker: $showPicker, color: $selectedColor)
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker()
    }
}
