//
//  SplashView.swift
//  flickr
//
//  Created by Jasmine Patel on 23/10/2023.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    @State private var sparklesScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                Color.green.opacity(0.8)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()) {
                            self.sparklesScale = 1.5
                        }
                    }
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Image(systemName: "sparkles")
                            .font(.system(size: 90))
                            .scaleEffect(sparklesScale)                    }
                    .padding(.trailing, 40)
                    .offset(y: +60)
                    Image("AppIconClear")
                        .resizable()
                        .scaledToFit()
                    HStack {
                        Image(systemName: "sparkles")
                            .font(.system(size: 90))
                            .scaleEffect(sparklesScale)
                        Spacer()
                    }
                    .padding(.leading, 40)
                    .offset(y: -60)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
