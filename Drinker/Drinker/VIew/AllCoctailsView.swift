//
//  AllCoctailsView.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 26.07.22.
//

import SwiftUI


struct AllCoctailsView: View {

    let viewModel: CoctailsViewModel
    let gradient = LinearGradient(colors: [.blue, .green],
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing)
    
    var body: some View {
        VStack {
            HStack{
                Text("All coctails")
                    .foregroundStyle( gradient)
                    .font(.largeTitle.bold())
            }
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                }
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3))], alignment: .center, spacing: 8) {
                    ForEach(viewModel.coctails) { coctail in
                        CoctailRoundView(coctail: coctail, networkManager: viewModel.networkManager)
                    }
                }
            }
            
            
        }
        .background(.white)
        .task {
            do {
                try await viewModel.getAllCoctails()
            } catch {
                print("Error", error) // TODO!!!!
            }
        }
    }
}

//struct AllCoctailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCoctailsView(viewModel: AllCoctailsViewModel(networkManager: CoctailsNetworkManager(), realmManager: RealmManager()))
//    }
//}
