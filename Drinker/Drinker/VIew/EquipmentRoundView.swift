//
//  EqipmentRoundView.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 29.07.22.
//

import SwiftUI
import RealmSwift

struct EquipmentRoundView: View {
    @ObservedRealmObject var equipment: EquipmentFromRealm
// @State private var isCoctailViewPresented = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: equipment.photo)!) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80)
                    .frame(height: 80)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            Text(equipment.name)
                .padding()
                .font(.footnote)
            HStack{
                Text(equipment.type)
                    .padding()
                    .font(.footnote)
                
                Text(equipment.unit)
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

//struct EqipmentRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        EqipmentRoundView()
//    }
//}
