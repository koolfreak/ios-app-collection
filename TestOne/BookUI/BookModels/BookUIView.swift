//
//  BookUIView.swift
//  TestOne
//
//  Created by Emmanuel Nollase on 3/16/23.
//

import SwiftUI

struct BookUIView: View {
    var body: some View {
        BookHomeUIView().preferredColorScheme(.light)
    }
}

struct BookUIView_Previews: PreviewProvider {
    static var previews: some View {
        BookUIView()
    }
}
