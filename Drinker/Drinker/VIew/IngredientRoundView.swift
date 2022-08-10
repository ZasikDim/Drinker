//
//  IngredientRoundView.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 30.07.22.
//

import SwiftUI
import RealmSwift

struct IngredientRoundView: View {
    @ObservedRealmObject var ingredient: IngredientFromRealm
    // @State private var isCoctailViewPresented = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: ingredient.photo) ?? URL(string: "https://papik.pro/uploads/posts/2022-02/1644066042_5-papik-pro-p-nakleika-fak-5.png")!) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80)
                    .frame(height: 80)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            Text(ingredient.name)
                .padding()
                .font(.footnote)
            HStack {
                Text(ingredient.type)
                    .padding()
                    .font(.footnote)
                
                Text(ingredient.unit)
                    .padding()
                    .font(.footnote)
            }
            
            Spacer()
        }
        .frame(alignment: .top)
        .background(.thinMaterial)
        //        .onTapGesture {
        //            isCoctailViewPresented.toggle()
        //        }
        //        .fullScreenCover(isPresented: $isCoctailViewPresented) {
        //            CoctailView(viewModel: CoctailViewModel(coctail: coctail, networkManager: networkManager), isCoctailViewPresented: $isCoctailViewPresented)
        //        }
    }
}

//struct IngredientRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientRoundView()
//    }
//}
