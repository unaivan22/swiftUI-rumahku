//
//  Saved.swift
//  Rumahku
//
//  Created by una ivan on 19/06/23.
//

import SwiftUI


struct SavedDetail : View {
    @StateObject private var viewModel = RumahViewModel()

    var body : some View {

        NavigationView{
            List(viewModel.rumahs.filter { $0.saved }) { rumah in
                NavigationLink(destination: DetailView(rumah: rumah)) {
                    VStack(spacing: 10){
                        ZStack(alignment: .topTrailing){
                            URLImage(urlString: rumah.thumbnail)
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width - 40,  height: 350)
                                .clipped()
                                .cornerRadius(12)
                                .aspectRatio(contentMode: .fill)
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 32))
                                .padding(.trailing, 10)
                                .padding(.top, 10)
                        }
                        
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
                .navigationBarTitle("Saved")
            .onAppear {
                viewModel.fetchRumahs()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
