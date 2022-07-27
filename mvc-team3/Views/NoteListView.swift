//
//  ContentView.swift
//  NoteCoreData
//
//  Created by Nadia Ramadhani on 18/05/22.
//

import SwiftUI

struct NoteListView: View {
    
    //@State private var showingSheet = false
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var noteListVM : NoteListViewModel
    @ObservedObject private var bookvm: BookFolderViewModel
    @State private var navigationLinkNotes: Bool = false
    @State private var navigationLinkImage: Bool = false
    @State private var navigationLinkImportMedia: Bool = false
    @State private var navigationLinkVoice: Bool = false
    @State private var showSheet = false
    
    
    init(vm: NoteListViewModel, bookvm: BookFolderViewModel) {
        self.noteListVM = vm
        self.bookvm = bookvm
    }
    
    private func deleteNote (at offsets: IndexSet) {
        offsets.forEach { index in
            let note = noteListVM.notes[index]
            noteListVM.deleteNote(noteId: note.id)
        }
    }

    var body: some View {
        NoteActionSheetView(navigationLinkNotes: $navigationLinkNotes, navigationLinkImage: $navigationLinkImage, navigationLinkImportMedia: $navigationLinkImportMedia, navigationLinkVoice: $navigationLinkVoice)
        
        VStack{
            if (self.noteListVM.notes.count == 0){
                Text("Tap + to add new item")
                    .foregroundColor(Color.secondary)
            } else {
                List {
                    ForEach(noteListVM.notes) { note in
                        NavigationLink(destination: NoteOpenView(vm: note)) {
                            HStack {
                                Image(systemName: "note.text")
                                    .frame(alignment: .leading)
                                    .padding()
                                
                                VStack{
                                    Text(note.noteTitle)
                                        .frame( alignment: .leading)
                                    
                                    Text(dateFormatter(date:note.noteDate))
                                        .foregroundColor(.gray)
                                        .italic()
                                        .frame( alignment: .leading)
                                }
                            }
                        }.navigationTitle("")
                        
                    }.onDelete(perform: deleteNote)
                    
                }
            }
        }
        //.navigationTitle("titleBook").navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    showSheet.toggle()
                    
                }, label: {
                    Image(systemName: "plus.circle.fill")
                    Text("New item")
                })
                .disabled((self.bookvm.savedEntities.count > 0 ) ? false: true)
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(
                        title: Text("Choose notes type"),
                        buttons: [
//                            .default(Text("New Folder"), action:{
//                            }),
                            .default(Text("Text Note"), action: {
                                withAnimation{
                                    navigationLinkNotes = true}
                            }),
                            .default(Text("Take a Photo"), action: {
                                withAnimation{
                                    navigationLinkImage = true}
                            }),
                            .default(Text("Import Media"), action: {
                                withAnimation{
                                    navigationLinkImportMedia = true}
                            }),
                            .default(Text("Voice Notes"), action: { withAnimation{
                                navigationLinkVoice = true}
                            }),
                            .cancel()
                        ]
                    )
                }
            
            }
        }
   

    }
}
//struct NoteListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewContext = NoteCoreManager.shared.persistentStoreContainer.viewContext
//        NoteListView(vm: NoteListViewModel(context: viewContext))
//        
//    }
//}
