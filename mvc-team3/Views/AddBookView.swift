import SwiftUI

struct AddBookView: View {
    @ObservedObject var bookvm : BookFolderViewModel
    @State private var titleBook:String = ""
    @State private var authorBook:String = ""
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
      NavigationView{
        VStack {
            Image("bookPlaceholder")
                .resizable()
                .scaledToFit()
                .padding()

                .frame(width: 250, height: 214, alignment: .center)
                .padding(.horizontal)
            
            Button("Change cover"){
                print("something")
            }
            .frame(width: 120, height: 10, alignment: .center)
          
            .padding(min(.infinity, 20))
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(25)

            
            HStack{
                Text ("Book Title")
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .padding(.leading)
                    .padding(.bottom)
                TextField("Add book title", text: $titleBook)
                    .padding(.trailing)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                
            }.padding(.top,25)
            HStack{
                Text ("Book Author")
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .padding(.leading)
                    
                TextField("Add book author", text: $authorBook)
                    .padding(.trailing)
                    .disableAutocorrection(true)
                
                
            }.padding(.top)
            Spacer()
        }
        .navigationTitle("Add Book")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {
            print("back")
            dismiss()
        }) {
            Text("Cancel")
        }, trailing: Button(action:{
            print("save")
            guard !titleBook.isEmpty && !authorBook.isEmpty else { return }
            bookvm.addBook(title: titleBook, author: authorBook)
            titleBook = ""
            authorBook = ""
            dismiss()
        }){
            Text("Save")
        }
        )
      }
        
    }
}

//struct addBookView_Preview: PreviewProvider {
//    @StateObject var vm = BookFolderViewModel()
//    static var previews: some View {
//        AddBookView(bookvm: vm)
//    }
//}
//
//

