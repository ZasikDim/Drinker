//
//  AllEquipmentsView.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 29.07.22.
//

import SwiftUI

struct AllEquipmentsView: View {
    
    let viewModel: EquipmentsViewModel
    
    var body: some View {
        VStack {
            Text("All equipments")
            // .foregroundStyle( gradient)
                .font(.title.bold())
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .center, spacing: 12) {
                    ForEach(viewModel.equipments) { equipment in
                        EquipmentRoundView(equipment: equipment)
                    }
                }

            }
            
            
        }
        .task {
            do {
                try await viewModel.getAllEquipments()
            } catch {
                print("Error", error) // TODO!!!!
            }
        }
        
    }
}

//struct AllEquipmentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllEquipmentsView()
//    }
//}
