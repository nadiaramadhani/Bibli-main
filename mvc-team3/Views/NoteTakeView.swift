//
//  NoteTakeView.swift
//  mvvm-team03
//
//  Created by Nadia Ramadhani on 14/05/22.
//

import SwiftUI

struct NoteTakeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @State private var noteTitle = ""
    @ObservedObject var vm: TakeNoteViewModel
    @State private var assignNoteIndex = 0
    var assignNote = ["Book1","Book2", "Book3"]
    
    init(vm: TakeNoteViewModel){
        self.vm = vm
    }
    
    
    
    var body: some View {
        Form{
            Section {
              
            
            TextField("Your title here", text: $vm.titleVar)
 //               .padding()
                .frame(height: 50, alignment: .center)
//                .border(Color.gray)
                .disableAutocorrection(true)
                
                
            TextEditor(text: $vm.noteVar)
                    .padding([.leading, .trailing], 4)
                    .frame( height:500 , alignment: .leading)
//                    .border(Color.gray)
                    .multilineTextAlignment(.leading)
                    .disableAutocorrection(true)
                
            }
            Section{
                Picker( selection: $assignNoteIndex, label:
                            Text ("Assign to")) {
                    ForEach(0..<assignNote.count) {
                        Text(self.assignNote[$0]).tag($0)
                    }
                }

            }
        }

        .navigationTitle("Text Note")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action:{
                dismiss()
            }){
                Text("Cancel")
            },
            trailing: Button(action:{
                vm.save()
                presentationMode.wrappedValue.dismiss()
            })
            {
                Text("Save")
            }
        )
        .navigationBarBackButtonHidden(true)
        
    }
}

struct NoteTakeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = NoteCoreManager.shared.persistentStoreContainer.viewContext
        
        NoteTakeView(vm: TakeNoteViewModel(context: viewContext))
    }
}


