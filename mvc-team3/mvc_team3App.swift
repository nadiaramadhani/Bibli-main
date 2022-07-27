//
//  mvc_team3App.swift
//  mvc-team3
//
//  Created by Jemi Damanik on 11/05/22.
//

import SwiftUI

@main
struct mvc_team3App: App {
//    @State private var isFirst: Bool = true
//    var body: some Scene {
//        WindowGroup {
//            if (isFirst==false) {
//                FirstOnBoardingView(isFirst: $isFirst)
//            }else{
//                MainScreenView()
//            }
//        }
//    }
    var body: some Scene {
        WindowGroup {
            FirstOnBoardingView()
        }
    }
}
