//
//  AddIngredient.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 28.07.22.
//

import SwiftUI

struct AddIngredientView: View {
    
    let viewModel: IngredientsViewModel

    @State private var name: String = ""
    @State private var photo: String = ""
    @State private var description: String = ""
    @State private var type: String = ""
    @State private var unit: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Ingredient's name", text: $name)
                    .padding()
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                TextField("Ingredient's description", text: $description)
                    .padding()
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                TextField("Link on photo", text: $photo)
                    .padding()
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()

                TextField("Ingredient's type", text: $type)
                    .padding()
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                
                TextField("Unit", text: $unit)
                    .padding()
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                
                Button {
                    Task {
                        do {
                            try await viewModel.addIngredient(name: name, description: description, photo: photo, type: type, unit: unit)
                            try await viewModel.getAllIngredients()
                            self.name = ""
                            self.photo = ""
                            self.description = ""
                            self.type = ""
                            self.unit = ""
                        } catch {
                            print("Error", error) // TODO!!!!
                        }
                    }
                } label: {
                    Text("Add")
                        .padding()
                        .font(.footnote.bold())
                        .background(LinearGradient(colors: [.green, .teal], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }

                    
            }
        }
        
    }
}

//struct AddIngredientView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddIngredientView()
//    }
//}
