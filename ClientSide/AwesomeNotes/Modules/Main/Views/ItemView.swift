//
//  ItemView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 17/08/2023.
//

import SwiftUI

struct ItemView: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: Constants.spacing) {
            Text(title)
                .font(.title2)
                .foregroundColor(.blue)
            Text(content)
                .font(.body)
        }
        .padding()
    }
}

extension ItemView {
    struct Constants {
        static let spacing: CGFloat = 5
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(title: "Demo",
                 content: "Demo")
    }
}
