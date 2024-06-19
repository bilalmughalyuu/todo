//
//  TLButtonView.swift
//  ToDoList
//
//  Created by Bilal on 12/06/2024.
//

import SwiftUI

struct TLButtonView: View {
    let title: String
    let backGroundColor: Color
    let action: () -> Void
    var body: some View {
        Button{
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(backGroundColor)
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
        .padding()
    }
}

#Preview {
    TLButtonView(title: "Button", backGroundColor: Color.blue, action: {
        
    })
}
