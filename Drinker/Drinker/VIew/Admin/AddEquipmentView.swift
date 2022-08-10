//
//  AddEquipmentView.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 29.07.22.
//

import SwiftUI

struct AddEquipmentView: View {
    
    let viewModel: EquipmentsViewModel

    @State private var name: String = ""
    @State private var photo: String = ""
    @State private var description: String = ""
    @State private var type: String = ""
    @State private var unit: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Equipment's name", text: $name)
                    .padding()
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                TextField("Equipment's description", text: $description)
                    .padding()
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                TextField("Link on photo", text: $photo)
                    .padding()
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()

                TextField("Equipment's type", text: $type)
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
                            try await viewModel.addEquipment(name: name, description: description, photo: photo, type: type, unit: unit)
                            try await viewModel.getAllEquipments()
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

//struct AddEquipmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEquipmentView()
//    }
//}
