
import SwiftUI

struct SearchDetail: View {
    
    var body: some View {
        NavigationView {
            SearchFinal()
        }.accentColor(.black)
            .padding(.horizontal, 12)
    }
}


struct SearchFinal: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = RumahViewModel()
    @State private var searchText = ""
    @State private var isSearching = false
    
    var filteredRumahs: [Rumah] {
        viewModel.rumahs.filter { searchText.isEmpty || $0.title.contains(searchText) }
    }
    
    var body: some View {
        //        NavigationView {
        VStack {
            TextField("Type your dream residence", text: $searchText, onCommit: {
                isSearching = true
                viewModel.fetchRumahs()
            })
//            .textFieldStyle(RoundedBorderTextFieldStyle())
           .cornerRadius(5)
           .padding(.horizontal,12)
           .frame(width: .infinity, height: nil)
           .padding(.all, 5)
//           .textFieldStyle(.roundedBorder)
           .font(Font.system(size: 24, design: .default))
           .multilineTextAlignment(.leading)
            
            if isSearching && filteredRumahs.isEmpty {
                Text("House not found")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(filteredRumahs) { rumah in
                    NavigationLink(destination: DetailViewSearch(rumah: rumah)) {
                        HStack(spacing: 10){
                            URLImage(urlString: rumah.thumbnail)
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipped()
                                .cornerRadius(12)
                                .aspectRatio(contentMode: .fill)
                            
                            VStack(alignment: .leading, spacing: 1){
                                Text(rumah.title)
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                                    .bold()
                                    .multilineTextAlignment(.leading)
                                HStack(spacing: 4){
                                    Text("\(rumah.kecamatan),".capitalized)
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 16))
                                    
                                    Text(rumah.kota.capitalized)
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 16))
                                }
                                
                            }
                        }
                    }.listRowSeparator(.hidden)
                }.listStyle(.plain)
            }
        }
        //            .navigationBarHidden(true)
        .navigationTitle("Search")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
            }
        }
        Spacer()
            .onAppear {
                viewModel.fetchRumahs()
            }
        //        }
        
    }
}

struct DetailViewSearch: View {
    @Environment(\.presentationMode) var presentationMode
    let rumah: Rumah
    
    var body: some View {
        //        ZStack(alignment: .topTrailing){
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                URLImage(urlString: rumah.thumbnail)
                //                .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 40,  height: 350)
                    .clipped()
                    .cornerRadius(20)
                
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
                .padding(.vertical,24)
                .frame(maxHeight: .infinity)
                .navigationBarHidden(false)
                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button(action: {
//                            presentationMode.wrappedValue.dismiss()
//                        }) {
//                            Image(systemName: "xmark")
//                        }
//                    }
//                }
        }
    }
}
