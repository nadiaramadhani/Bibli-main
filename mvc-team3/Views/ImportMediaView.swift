
struct BookListView: View {
    @StateObject var vm = BookFolderViewModel()
    var body: some View {
        List {
            ForEach(vm.savedEntities) { entity in
                //harusnya bisa di select
                Text(entity.titleBook ?? "-")
            }
        }

    }
}


import SwiftUI

struct ImportMediaView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: ImageViewModel
    @State private var titleImage:String = ""
    @State private var book:String = ""
    
    var body: some View {
        
        Form{
            Section{
                VStack{
                    if let image = vm.image {
                       // ZoomableScrollView {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                        //}
                    } else {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .opacity(0.6)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.horizontal)
                    }
                    Button {
                        vm.source = .library
                        vm.showPhotoPicker()
                    } label: {
                        Text("Import Image").foregroundColor(Color("AccentColor"))
                            .frame(alignment: .center)
                    }
                    .padding()
                    
                }
            
                
            }
            Section{
                TextField("Title", text: $titleImage)
                    .padding()
            }
            Section{
                HStack{
                    Text ("Assign to")
                        .frame(maxWidth: .infinity , alignment: .leading)
                        .padding(.horizontal)
                    Spacer()
                    NavigationLink(destination: BookListView()){
                        
                    }
                }
            }
            
        }
        .sheet(isPresented: $vm.showPicker) {
            ImagePickerVC(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                .ignoresSafeArea()
        }
        .navigationTitle("Take a Photo").navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action:{
                dismiss()
            }){
                Text("Cancel")
            },
            trailing: Button(action:{
                //                 vm.save()
                //                 presentationMode.wrappedValue.dismiss()
            })
            {
                Text("Save")
            }
        )
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ImportMediaView_Previews: PreviewProvider {
    static var previews: some View {
        TakeImageView()
            .environmentObject(ImageViewModel())
    }
}

////struct ImportMediaView_Previews: PreviewProvider {
////    static var previews: some View {
////        ImportMediaView()
////    }
////}
//


