//
//  CoctailView.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 27.07.22.
//

import SwiftUI
struct CoctailView: View {
    
    let viewModel: CoctailViewModel
    
    @Binding var isCoctailViewPresented: Bool
    @State var isDescriptionOpen: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            VStack(alignment: .leading) {
                
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: URL(string: viewModel.coctail.photo)!) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: UIScreen.main.bounds.width)
                            .frame(width: UIScreen.main.bounds.width)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: UIScreen.main.bounds.width)
                    .frame(width: UIScreen.main.bounds.width)
                    
                    Button {
                        isCoctailViewPresented.toggle()
                    } label: {
                        Text("Close")
                    }
                    .padding()
                    
                    VStack{
                        Spacer()
                        HStack {
                            Text(viewModel.coctail.name)
                                .font(.largeTitle.bold())
                                .padding()
                            Spacer()
                        }
                    }
                }
                .foregroundColor(.white)
                
                HStack {
                    
                    HeartButton(isLiked: viewModel.$coctail.isLiked)

                    
                }

                HStack(alignment: .top) {
                    Text(viewModel.coctail.coctailDescription)
                        .font(.footnote)
                        .lineSpacing(10)
                        .lineLimit(isDescriptionOpen ? nil : 2)
                    Spacer()
                    Button {
                        withAnimation(.spring()) {
                            isDescriptionOpen.toggle()
                        }
                    } label: {
                        Image(systemName: "arrowtriangle.right.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)
                     //       .padding(.trailing)
                            
                    }

                }
                .padding()
                .padding(.vertical)
                
                Text("You need this:")
                
                HStack(alignment: .top, spacing: 10) {
                    
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.title)
                        
                        
                        ForEach(viewModel.coctail.ingredients) { ingredient in
                            Divider()
                            HStack(alignment: .center, spacing: 10) {
                                AsyncImage(url: URL(string: ingredient.ingredient?.photo ?? "")) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 48, height: 48)
                                            .clipShape(Circle())
                                            
                                    } else if phase.error != nil {
                                        Color.red // Indicates an error.
                                    } else {
                                        Color.blue // Acts as a placeholder.
                                    }
                                }
                                .frame(width: 48, height: 48)
                                
                                VStack(alignment: .leading) {
                                    Text(ingredient.ingredient?.name ?? "")
                                        .font(.footnote.bold())
    
                                        Text(String(ingredient.quantity) + " ")
                                            .font(.footnote)
                                        + Text(ingredient.ingredient?.unit ?? "")
                                            .font(.footnote)
                                    
                                }

                      
                            }

                        }
                       
                    }

                    VStack(alignment: .leading) {
                        Text("Equipments")
                            .font(.title)
                        
                        
                        ForEach(viewModel.coctail.equipments) {equipment in
                            Divider()
                            HStack(alignment: .center, spacing: 10) {
                                    AsyncImage(url: URL(string: equipment.equipment?.photo ?? "")) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 48, height: 48)
                                                .clipShape(Circle())
                                            
                                        } else if phase.error != nil {
                                            Color.red // Indicates an error.
                                        } else {
                                            Color.blue // Acts as a placeholder.
                                        }
                                    }
                                    .frame(width: 48, height: 48)
                                    
                                    Text(equipment.equipment?.name ?? "")
                                        .font(.footnote)

                  //              Spacer()
//                                Text(equipment.equipment?.unit ?? "")
//                                    .padding()
//                                    .font(.footnote)
                            }
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                }
                .padding()
                .background(.gray)

                Text("Recipe:")
                    .font(.title)
                    .padding()
                

                
                ForEach(Array(zip(viewModel.coctail.recipe.indices, viewModel.coctail.recipe)), id: \.0) { step, item in
                    
                    HStack {
                        Text(String(step + 1))
                            .font(.body)
                            .padding()
                            .background(.red)
                            .clipShape(Circle())
                        Text(item)
                            .font(.body)
                            .padding()
                        Spacer()
                    }
                    .padding()
                    .background(.mint)
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
                
                
            }
            .task {
                if viewModel.coctail.coctailDescription.isEmpty {
                    do {
                        try await viewModel.getAllCoctailInfoById(id: viewModel.coctail.id)
                        
                    } catch {
                        print("Error", error) // TODO!!!!
                    }
                }
            }
        }
    }
}

//struct CoctailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoctailView()
//    }
//}
