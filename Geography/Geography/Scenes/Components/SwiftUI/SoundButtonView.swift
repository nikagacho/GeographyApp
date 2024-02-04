//
//  SoundButtonView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 04.02.24.
//

import SwiftUI

struct SoundButtonView: View {
    @Binding var isSoundOn: Bool
    
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
