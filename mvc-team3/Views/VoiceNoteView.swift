//
//  VoiceNoteView.swift
//  mvvm-team03
//
//  Created by Aulia Rahmi on 20/05/22.
//

import SwiftUI

struct VoiceNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm = VoiceNoteViewModel()
    
    @State private var showingList = false
    @State private var showingAlert = false
    
    @State private var effect1 = false
    @State private var effect2 = false
    
    var body: some View {
        ZStack{
            
            Image("back")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                
            
            VStack{
//                HStack{
//                    Text("Voice Note")
//                        .foregroundColor(.white)
//                        .font(.system(size: 20 , weight : .bold))
//
//                    Spacer()
//
//                    Button(action: {
//                        if vm.isRecording == true {
//                            vm.stopRecording()
//                        }
//                        vm.fetchAllRecording()
//                        showingList.toggle()
//                    }) {
//                        Image(systemName: "list.bullet")
//                            .foregroundColor(.white)
//                            .font(.system(size: 20, weight: .bold))
//                    }.sheet(isPresented: $showingList, content: {
//                        VoiceNoteListView()
//                    })
//
//                }
//
//                Spacer()
                
                if vm.isRecording {
                    
                    VStack(alignment : .leading , spacing : -5){
                        HStack (spacing : 3) {
                            Image(systemName: vm.isRecording && vm.toggleColor ? "circle.fill" : "circle")
                                .font(.system(size:10))
                                .foregroundColor(.red)
                            Text("Rec")
                        }
                        Text(vm.timer)
                            .font(.system(size:60))
                            .foregroundColor(Color("AccentColor"))
                    }
                    
                } else {
                    VStack{
                        Text("Press the Recording Button below")
                            .foregroundColor(Color("AccentColor"))
                            .fontWeight(.bold)
                        Text("and Stop when its done")
                            .foregroundColor(Color("AccentColor"))
                            .fontWeight(.bold)
                    }.frame(width: 300, height: 150, alignment: .center)
                    
                    
                }
                
                Spacer()
                Spacer()
                
                ZStack {
                    
                    Circle()
                        .frame(width: 70, height: 70)
                        .foregroundColor(vm.isRecording ? .red : Color("AccentColor"))
                        .scaleEffect(effect2 ? 1 : 0.8)
                        
                       // .animation( Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(1))
                        .onAppear(){
                            self.effect2.toggle()
                        }
                    
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(vm.isRecording ? .red : Color("AccentColor"))
                        .scaleEffect(effect2 ? 1 : 1.5)
                        //.animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(2))
                        .onAppear(){
                            self.effect1.toggle()
                        }
                    
                    
                    Image(systemName: vm.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 45))
                        .onTapGesture {
                            if vm.isRecording == true {
                                vm.stopRecording()
                            } else {
                                vm.startRecording()
                                
                            }
                        }
                    
                }
                
                
                
                Spacer()
                
            }
            .padding(.leading,25)
            .padding(.trailing,25)
            .padding(.top , 70)
            
//                Circle()
//                    .frame(width: 230, height: 230)
//                    .foregroundColor(Color(#colorLiteral(red: 0.4157493109, green: 0.8572631, blue: 0.9686274529, alpha: 0.4940355314)))
//                    .scaleEffect(effect2 ? 1 : 0.8)
//                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.5))
//                    .offset(x: 160, y: 400)
//
//                Circle()
//                    .frame(width: 230, height: 230)
//                    .foregroundColor(Color(#colorLiteral(red: 0.4157493109, green: 0.8572631, blue: 0.9686274529, alpha: 0.4940355314)))
//                    .scaleEffect(effect2 ? 1 : 0.8)
//                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(1))
//                    .offset(x: 110, y: 400)
            
            
        }
        .navigationTitle("Voice Note").navigationBarTitleDisplayMode(.inline)
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

struct VoiceNoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceNoteView()
    }
}
