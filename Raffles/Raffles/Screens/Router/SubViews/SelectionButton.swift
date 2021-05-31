//
//  SelectionButton.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import SwiftUI

//Button to switch between Register View, Participant View, and Winner View
struct SelectionButton: View {
    let option: ScreenOption
    @Binding var currentOption: ScreenOption
    
    var color: Color {
        //Buttons that aren't associated with the current selection are greyed out.
        option == currentOption ? .getSelectionColor(using: option) : .secondary
    }
    
    var body: some View {
        Button(action: goToScreen) {
            VStack {
                Image(systemName: option.systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 22)
                Text(option.rawValue.capitalized)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .foregroundColor(color)
        }
    }
    
    //MARK:- Private Methods
    private func goToScreen() {
        withAnimation {
            currentOption = option
        }
    }
}


struct SelectionButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectionButton(option: .participants, currentOption: .constant(.participants))
    }
}
