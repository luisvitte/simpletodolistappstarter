//
//  ContentView.swift
//  TestApp
//
//  Created by Luis Alessandro Vitte Soto on 20/02/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: []) var items: FetchedResults<Item>
    
    @State var todotext: String = ""
    
    func saveItem() {
        
        let item = Item(context: self.moc)
        item.name = self.todotext
        
        try? self.moc.save()
        
    }
    
    var body: some View {
        NavigationView {
            List {
                TextField("Reminde me...", text: $todotext)
                Button(action: {
                    saveItem()
                }) {
                    HStack {
                        Spacer()
                        Text("Add new")
                        Spacer()
                    }
                }
                ForEach(items, id: \.self) { item in
                    Text(item.wrappedName)
                }
                
            }.listStyle(InsetListStyle())
            .navigationTitle("Todo list")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
