import SwiftUI

struct TakeImageView: View {
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
                       
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(minWidth: 0, maxWidth: .infinity)
                        
                    } else {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .opacity(0.6)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.horizontal)
                    }
                    Button {
                        vm.source = .camera
                        vm.showPhotoPicker()
                    } label: {
                        Text("Camera").foregroundColor(Color("AccentColor"))
                            .frame(alignment: .center)
                    }
                    .padding()
                    
                }
                
            }
            Section{
                TextField("Title", text: $titleImage)
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
        
        .alert("Error", isPresented: $vm.showCameraAlert, presenting: vm.cameraError, actions: { cameraError in
            cameraError.button
        }, message: { cameraError in
            Text(cameraError.message)
        })
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

struct TakeImageView_Previews: PreviewProvider {
    static var previews: some View {
        TakeImageView()
            .environmentObject(ImageViewModel())
    }
}
