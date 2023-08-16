//
//  DynamicTextField.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import SwiftUI

struct DynamicTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text.isEmpty ? $text : placeholder)
                .frame(minHeight: 100)
                .padding(.top, text.isEmpty ? 8 : 0)
                .background(Color.white)
                .cornerRadius(8)
        }
    }
}

struct DynamicTextField_Previews: PreviewProvider {
    static var previews: some View {
        DynamicTextField(text: .constant("Text"),
                         placeholder: "Text")
    }
}
