//
//  CoctailRoundView.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 27.07.22.
//

import SwiftUI
import RealmSwift

struct CoctailRoundView: View {
    
    @ObservedRealmObject var coctail: CoctailfromRealm
    let networkManager: CoctailsNetworkManager
    
    @State private var isCoctailViewPresented = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: coctail.photo)!) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
                        .cornerRadius(20)
                } placeholder: {
                    ProgressView()
                }
                
                if coctail.isLiked {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(.red)
                }
            }
            
            Text(coctail.name)
                .font(.footnote)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 2)
        .onTapGesture {
            isCoctailViewPresented.toggle()
        }
        .fullScreenCover(isPresented: $isCoctailViewPresented) {
            CoctailView(viewModel: CoctailViewModel(coctail: coctail, networkManager: networkManager), isCoctailViewPresented: $isCoctailViewPresented)
        }
    }
}

//struct CoctailRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoctailRoundView()
//    }
//}
