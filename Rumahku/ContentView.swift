//
//  ContentView.swift
//  Rumahku
//
//  Created by una ivan on 17/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            TabView {
                Home()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                Home()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                Home()
                    .tabItem {
                        Image(systemName: "clock.fill")
                        Text("History")
                    }
                
                Home()
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                        Text("Saved")
                    }
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
    var body : some View {

        NavigationView{
            Kontent()
                .navigationBarItems(
                    leading:
                        HStack{
                            Button(action: {print("Hello Button")}){
                                Image("rumahku")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 120, height:30)
                            }
                        },
                    trailing:
                        HStack(spacing:10){
//                            Button(action: {print("Hello Print")}){
//                                Image(systemName: "tray.full")
//                                    .foregroundColor(Color.secondary)
//                            }
//
//                            Button(action: {print("Hello Print")}){
//                                Image(systemName: "video.fill")
//                                    .foregroundColor(Color.secondary)
//                            }
//
//                            Button(action: {print("Hello Print")}){
//                                Image(systemName: "magnifyingglass")
//                                    .foregroundColor(Color.secondary)
//                            }
                            
                            Button(action: {print("Hello Print")}){
                                Image("profile")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width:30, height:30)
                                    .clipShape(Circle())
                            }
                        }
                )
                .navigationBarTitle("", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Kontent : View {
    @StateObject private var viewModel = RumahViewModel()
    //Property Data
    
    var body : some View {
        VStack(alignment: .leading){
            HStack{
                Text("Nearby")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .bold()
            }.padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 18))
            
            List(viewModel.rumahs) { rumah in
                NavigationLink(destination: DetailView(rumah: rumah)) {
                    HStack(spacing: 15){
                        URLImage(urlString: rumah.thumbnail)
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text(rumah.title)
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                            
                            Text("Rp \(rumah.price)")
                                .font(.system(size: 18))
                                .foregroundColor(.blue)
                            
                            HStack{
                                Group{
                                    Image(systemName: "bed.double.fill")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 12))
                                    Text("\(rumah.bedroom)").foregroundColor(.gray)
                                        .font(.system(size: 12))
                                }
                                Group{
                                    Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 12))
                                    Text("\(rumah.long * rumah.wide)").foregroundColor(.gray)
                                        .font(.system(size: 12))
                                }
                            }
                        }
                    }
                }.listRowSeparator(.hidden)
            }.listStyle(.plain)
            //                    .navigationBarTitle("Rumah Pilihan")
                .onAppear {
                    viewModel.fetchRumahs()
                }
            //        .background(Color.red.edgesIgnoringSafeArea(.all))
                .listStyle(.plain)
            //        .listStyle(.inset)
            //        .listStyle(.insetGrouped)
            
        }.frame(height: 650)
    }
}

//Buat kerangka
struct cellKontent : View {
    var imageKontent: String
    var profilKontent: String
    var judul: String
    var deskripsi: String
    var durasi: String
    
    var body : some View {
        //kontent framework
        VStack{
            ZStack(alignment: .bottomTrailing){
                Image(imageKontent)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                Text(durasi)
                    .padding(.all, 5)
                    .foregroundColor(Color.white)
                    .font(.caption)
                    .background(Color.black)
                    .cornerRadius(5)
                    .padding(.trailing, 5)
                    .padding(.bottom, 5)
            }
            
            HStack(spacing:20){
                Image(profilKontent)
                    .resizable()
                    .frame(width:30, height:30)
                    .clipShape(Circle())
                
                VStack(alignment: .leading){
                    Text(judul).font(.headline)
                    HStack{
                        Text(deskripsi).font(.caption)
                    }
                }
                Spacer()
                Image(systemName: "list.bullet")
            }
        }
        .padding(.top, 20)
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



struct DetailView: View {
    let rumah: Rumah
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            VStack(alignment: .leading, spacing: 20) {
                
                URLImage(urlString: rumah.thumbnail)
    //                .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 40,  height: 200)
                    .clipped()
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 10){
                    Text(rumah.title)
                        .font(.largeTitle)
                    
                    Text("Rp: \(rumah.price)")
                        .font(.system(size: 22))
                        .foregroundColor(.blue)
                        .bold()
                    
                    HStack{
                        Text(rumah.kecamatan)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 16))
                        Text(rumah.kota)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 16))
                    }
                }
                
                HStack{
                    Group{
                        Image(systemName: "bed.double.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text("\(rumah.bedroom)")
                            .font(.system(size: 12))
                    }
                    Group{
                        Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text("\(rumah.long * rumah.wide)")
                            .font(.system(size: 12))
                    }
                    HStack{
                        Image(systemName: "drop.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text("\(rumah.bathroom)")
                            .font(.system(size: 12))
                    }
                    
                }
                
                HStack(spacing: 15 ){
                    URLImage(urlString: rumah.photoseller)
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(32)
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Penjual")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                         Text(rumah.seller)
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                        
                    }
                    Image(systemName: "message.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 22))
                }
   
                Text(rumah.description)
                    .font(.body)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                
                
            }.padding(.horizontal,24)
        }
    }
}
