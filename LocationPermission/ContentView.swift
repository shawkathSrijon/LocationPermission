//
//  ContentView.swift
//  LocationPermission
//
//  Created by Simec Sys Ltd. on 7/1/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = LocationViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Your location: ")
                    .fontWeight(.heavy)
                Text(viewModel.userLocation == nil ? "Locating.." : viewModel.userAddress)
                    .fontWeight(.heavy)
                    .foregroundColor(.pink)
            }
            Divider()
            Spacer()
        }
        .onAppear {
            viewModel.locationManager.delegate = viewModel
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
