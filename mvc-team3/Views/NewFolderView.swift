//
//  NewFolderView.swift
//  mvvm-team03
//
//  Created by Nadia Ramadhani on 22/05/22.
//

import SwiftUI

struct NewFolderView: View {
    @State private var folderName = ""
    var body: some View {
        Form{
            Section{
                TextField("Folder name", text: $folderName)
            }
            Section{
                
            }
        }
        
    }
}

struct NewFolderView_Previews: PreviewProvider {
    static var previews: some View {
        NewFolderView()
    }
}
