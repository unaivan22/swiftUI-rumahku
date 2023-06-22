//
//  ContentView.swift
//  Rumahku
//
//  Created by una ivan on 17/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    var body: some View {
        VStack{
            TabView(selection: $selectedTab) {
                Home()
                    .tabItem {
                        Image("home")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("Home")
                    }.tag(0)
                
                HistoryDetail()
                    .tabItem {
                        Image("history")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("History")
                    }.tag(1)
                
                SavedDetail()
                    .tabItem {
                        Image("bookmark")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("Saved")
                    }.tag(2)
                
                ProfileDetail()
                    .tabItem {
                        Image("profile")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("Profile")
                    }.tag(3)
            }
            .accentColor(.black)
        }.background(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





struct Home : View {
    @State private var readyToNavigate : Bool = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingPageSearchDetail = false
    
    var body : some View {
        
        NavigationView{
            MainContent()
                .navigationBarTitleDisplayMode(.inline)
            
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
//                        NavigationLink(destination: SearchDetail()) {
//                            Image(systemName: "magnifyingglass.circle.fill").foregroundColor(.gray)
//                                    .font(.system(size: 24))
//                        }.navigationBarTitle("Home", displayMode: .inline)
//                            .navigationBarBackButtonHidden(true)
                        
                        Button(action: {
                            isShowingPageSearchDetail = true
                        }) {
                            Image(systemName: "magnifyingglass.circle.fill").foregroundColor(.gray)
                                    .font(.system(size: 24))
                        }
                        
                    }
                    
                    ToolbarItem(placement: .principal) {
                        VStack{
                            Text("Current location")
                                .font(.system(size: 16))
                                .foregroundColor(.black)

                            Text("Sukolilo, Madiun, East Java")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 2){
                            Image("sort")
                                .foregroundColor(.gray)
                                .font(.system(size: 18))
                        }
                    }
            }.sheet(isPresented: $isShowingPageSearchDetail) {
                SearchDetail()
            }
        }
    }
}

struct MainContent : View {
    @StateObject private var viewModel = RumahViewModel()
    //Property Data
    
    var body : some View {
        List(viewModel.rumahs) { rumah in
            NavigationLink(destination: DetailView(rumah: rumah)) {
                VStack(spacing: 10){
                    URLImage(urlString: rumah.thumbnail)
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 40,  height: 350)
                        .clipped()
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 6){
                        Text(rumah.title)
                            .font(.custom("Manrope-Bold", size: 24))
                            .foregroundColor(.black)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Text("Rp \(rumah.price)")
                            .font(.custom("Manrope-Light", size: 20))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                        
                        HStack(){
                            ///untukk set width
                        }.frame(width: UIScreen.main.bounds.width - 40)
                    }.frame(width: UIScreen.main.bounds.width)
                }
                .padding(.bottom, 20)
                .padding(.leading, 25)
                Spacer()
            }.listRowSeparator(.hidden)
        }.listStyle(.inset)
            .frame(maxHeight: .infinity)
        .onAppear {
            viewModel.fetchRumahs()
        }
    }
}

struct URLImage: View {
    let urlString: String
    
    var body: some View {
        if let url = URL(string: urlString), let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
        } else {
            Image(systemName: "photo")
                .resizable()
        }
    }
}



