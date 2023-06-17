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
                        Image(systemName: "house")
                            .environment(\.symbolVariants, .none)
                        Text("Home")
                    }
                
                Home()
                    .tabItem {
                        Image(systemName: "clock")
                            .environment(\.symbolVariants, .none)
                        Text("History")
                    }
                
                Home()
                    .tabItem {
                        Image(systemName: "bookmark")
                            .environment(\.symbolVariants, .none)
                        Text("Saved")
                    }
                Home()
                    .tabItem {
                        Image(systemName: "person")
                            .environment(\.symbolVariants, .none)
                        Text("Profile")
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
//                .navigationBarItems(
//                    leading: HStack{
//                        TextField("Search ...", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
//                            .padding(.vertical, 7)
//                            .padding(.horizontal, 12)
//                            .background(Color(.systemGray6))
//                            .cornerRadius(12)
//                            .padding(.bottom, 24)
//                            .frame(maxWidth: .infinity)
//
//                    }
//                    leading:
//                        HStack{
//                            Button(action: {print("Hello Button")}){
//                                Image("rumahku")
//                                    .renderingMode(.original)
//                                    .resizable()
//                                    .frame(width: 120, height:30)
//                            }
//                        },
//                    trailing:
//                        HStack(spacing:10){
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
//
//                            Button(action: {print("Hello Print")}){
//                                Image("profile")
//                                    .renderingMode(.original)
//                                    .resizable()
//                                    .frame(width:30, height:30)
//                                    .clipShape(Circle())
//                            }
//                        }
//                )
//                .navigationBarTitle("", displayMode: .inline)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        Text("Asc")
                            .foregroundColor(.black)
                    }
                    
                    ToolbarItem(placement: .principal) {
                        
                        TextField("Search ...", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 12)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal, 8)
                            .padding(.top, 24)
                            .padding(.bottom, 24)
                            .frame(maxWidth: .infinity)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 2){
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundColor(.black)
                                .font(.system(size: 14))
//                            Text("Sort")
//                                .foregroundColor(.blue)

                        }
                    }
                    
                    
                }
        }.padding(.horizontal, 12)
    }
}

struct Kontent : View {
    @StateObject private var viewModel = RumahViewModel()
    //Property Data
    
    var body : some View {
        VStack(alignment: .leading){
            HStack(alignment: .center){
                Image(systemName: "location.circle.fill")
                .foregroundColor(Color.orange)
                
                Text("Sukolilo, Madiun, East Java")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(EdgeInsets(top: 0, leading: 18, bottom: 10, trailing: 18))
            .frame(maxWidth: .infinity)
            
            List(viewModel.rumahs) { rumah in
                NavigationLink(destination: DetailView(rumah: rumah)) {
                    VStack(spacing: 10){
                        URLImage(urlString: rumah.thumbnail)
//                            .frame(width: 100, height: 100)
//                            .aspectRatio(contentMode: .fill)
//                            .cornerRadius(8)
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 40,  height: 350)
                            .clipped()
                            .cornerRadius(12)
                        
                        VStack(alignment: .leading, spacing: 6){
                            Text(rumah.title)
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                                .bold()
                                .multilineTextAlignment(.leading)
                            Text("Rp \(rumah.price)")
                                .font(.system(size: 20))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.leading)
                            
                            HStack(){
                                ///untukk set width
                            }.frame(width: UIScreen.main.bounds.width - 40)
                        }.frame(width: UIScreen.main.bounds.width)
                    }.padding(.bottom, 20)
                    .padding(.leading, 20)
                }.listRowSeparator(.hidden)
            }.listStyle(.inset)
            //                    .navigationBarTitle("Rumah Pilihan")
            .onAppear {
                viewModel.fetchRumahs()
            }
            //        .background(Color.red.edgesIgnoringSafeArea(.all))
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
//        ZStack(alignment: .topTrailing){
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                URLImage(urlString: rumah.thumbnail)
                //                .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 40,  height: 350)
                    .clipped()
                    .cornerRadius(20)
                
                VStack(alignment: .leading, spacing: 2){
                    Text(rumah.title)
                        .font(.system(size: 30))
                        .bold()
                    
                    Text("Rp: \(rumah.price)")
                        .font(.system(size: 22))
                        .foregroundColor(.black)
                        .bold()
                        .padding(.bottom, 6)
                    
                    HStack{
                        Image(systemName: "location.circle.fill")
                            .foregroundColor(Color.orange)
                        
                        Text("\(rumah.kecamatan),".capitalized)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 16))
                        
                        Text(rumah.kota.capitalized)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 16))
                    }
                }.padding(.bottom, 1)
                
                HStack(spacing: 16){
                    HStack(spacing: 6){
                        Image(systemName: "bed.double.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                        Text("\(rumah.bedroom)")
                            .font(.system(size: 16))
                    }
                    HStack(spacing: 6){
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                        Text("\(rumah.long * rumah.wide) m²")
                            .font(.system(size: 16))
                    }
                    HStack(spacing: 6){
                        Image(systemName: "drop.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                        Text("\(rumah.bathroom)")
                            .font(.system(size: 16))
                    }
                    
                }.padding(.bottom, 10)
                
                HStack(spacing: 12) {
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
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Image(systemName: "message.fill")
                        .foregroundColor(.black)
                        .font(.system(size: 22))
                            Spacer()
                }.padding()
                    .background(.white)
                    .cornerRadius(20) /// make the background rounded
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.secondary, lineWidth: 1)
                    )
                
                Text(rumah.description)
                    .font(.body)
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                
                
            }.padding(.horizontal,24)
                .frame(width: UIScreen.main.bounds.width)
        }
//        }
    }
}
