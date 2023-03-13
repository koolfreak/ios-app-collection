//
//  Created by Emmanuel Nollase on 1/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var todos: [Todo] = []
    
    var body: some View {
        VStack {
            Text("Todos")
            List {
                ForEach(todos) { todo in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(todo.title).fontWeight(.bold)
                        Text(todo.body)
                    }
                }
            }
        }
        .task {
            Task {
                await getTodos()
            }
        }
        .padding()
    }
    
    private func getTodos() async {
        
        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let (data, _) = try await URLSession.shared.data(for: request)
            
            todos = try JSONDecoder().decode([Todo].self, from: data)
            
        }catch {
            print(error)
        }
    }
}

struct Todo: Codable, Identifiable {
    let title: String
    let body: String
    let id: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
