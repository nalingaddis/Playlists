//
//  ContentView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/14/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                self.title
                self.loginButton
            }
            .padding(geo.size.width / 11)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(5)
            .frame(width: geo.size.width / 11 * 9, height: geo.size.height)
            
        }
        .background(Color("SpotifyBlack"))
        .edgesIgnoringSafeArea(.all)
    }
    
    private var title: some View {
        Text("Login with")
        .style(TitleStyle())
    }
        
    private var loginButton: some View {
        GeometryReader { geo in
            Button(action: {
                Authenticator.login()
            }) {
                Image("Spotify_Logo_RGB_White")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .style(SimpleButtonStyle())
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
