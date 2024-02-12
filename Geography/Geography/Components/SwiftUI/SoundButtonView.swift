//
//  SoundButtonView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 04.02.24.
//

import SwiftUI

struct SoundButtonView: View {
    //MARK: - Property
    @Binding var isSoundOn: Bool
    //MARK: - Body
    var body: some View {
        Button {
            isSoundOn.toggle()
        } label: {
            if isSoundOn == true {
                Image(systemName: "speaker.slash.fill")
            } else {
                Image(systemName: "speaker.fill")
            }
        }
        
    }
}
