//
//  DetailView.swift
//  Rumahku
//
//  Created by una ivan on 17/06/23.
//

import SwiftUI
struct DetailView: View {
    let rumah: Rumah
    
    @State private var shouldSaved = true
    
    var body: some View {
        //        ZStack(alignment: .topTrailing){
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
//                URLImage(urlString: rumah.thumbnail)
//                //                .resizable()
//                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.width - 40,  height: 350)
//                    .clipped()
//                    .cornerRadius(20)
                
                ZStack(alignment: .topTrailing){
                    URLImage(urlString: rumah.thumbnail)
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 40,  height: 350)
                        .clipped()
                        .cornerRadius(12)
                        .aspectRatio(contentMode: .fill)
                    
                    if shouldSaved {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 32))
                            .padding(.trailing, 10)
                            .padding(.top, 10)
                    } else {
                        Text("Icon not available")
                    }
                    
//                    Image(systemName: "heart.fill")
//                        .foregroundColor(.red)
//                        .font(.system(size: 32))
//                        .padding(.trailing, 10)
//                        .padding(.top, 10)
                }
                
                VStack(alignment: .leading, spacing: 2){
                    Text(rumah.title)
                    //                        .font(.system(size: 30))
                        .font(.custom("Manrope-Bold", size: 36))
                    
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
                        Image(systemName: "bed.double")
                            .environment(\.symbolVariants, .none)
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                        Text("\(rumah.bedroom)")
                            .font(.system(size: 16))
                    }
                    HStack(spacing: 2){
                        Image( "ruler")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                        Text("\(rumah.long * rumah.wide) m²")
                            .font(.system(size: 16))
                    }
                    HStack(spacing: 2){
                        Image("drop")
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
                    .font(.custom("Manrope-Regluar", size: 16))
                    .foregroundColor(.secondary)
                
                
            }.padding(.horizontal,24)
                .frame(width: UIScreen.main.bounds.width)
        }
        //        }
    }
}
