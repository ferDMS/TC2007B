//
//  ContentView.swift
//  EjemploConsumirAPI
//
//  Created by PEZ on 03/09/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var mensaje = ""
    @State private var listaPosts : Array<Post> = []
    
    // Call API to obtain a plain text string
    func callAPIBasica() {
        // In case the assignment is not successful, do the else
        // If we can't reach the resource, then we do the else
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts/1")
        else {
            return
        }
        // Most programming languages perform async API calls
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            // Check whether we got data back
            // We could also check by response status
            if (data != nil){
                // Assign the entire JSON to a string
                if let datosAPI = String(data: data!, encoding: .utf8){
                    print(datosAPI)
                }
            }
        }
        // This starts the data task.
        // Until calling resume(), it won’t perform the network request
        task.resume()
        return
    }
    
    
    // Instead of just obtaining a plain text, now we convert the response into a JSON
    func callAsyncAPI() {
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts/1")
        else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            // New instance of a JSON decoder
            let jsonDecoder = JSONDecoder()
            if (data != nil){
                // Do-catch is the same as Try-catch in other languages
                do{
                    // Use `try` to let the `do` know that we might get an error from this
                    // Decode JSON type data from `data` into a Post instance
                    // So, postItem is thus a Post instance with accessable items
                    // Post.self is used to refer to the type itself, not an instance of the type (e.g.: like we would do in postItem : Post)
                    let postItem = try jsonDecoder.decode(Post.self, from: data!)
                    print("Id: \(postItem.id) - Titulo: \(postItem.title) ")
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
        return
    }
    
    
    // The API call is still sent in an asyncrhonous matter, but now we are waiting for the task to finish before we continue the code execution
    // This method will be able to assign to the `mensaje` attribute
    func callSyncAPI() {
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts/1")
        else{
            return
        }
        
        var mensajeTemp = ""
        
        let group = DispatchGroup()
        group.enter()
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            // New instance of a JSON decoder
            let jsonDecoder = JSONDecoder()
            if (data != nil){
                // Do-catch is the same as Try-catch in other languages
                do{
                    // Use `try` to let the `do` know that we might get an error from this
                    // Decode JSON type data from `data` into a Post instance
                    // So, postItem is thus a Post instance with accessable items
                    // Post.self is used to refer to the type itself, not an instance of the type (e.g.: like we would do in postItem : Post)
                    let postItem = try jsonDecoder.decode(Post.self, from: data!)
                    print("Id: \(postItem.id) - Titulo: \(postItem.title) ")
                    
                    // Assign one of the properties to our local var
                    mensajeTemp = postItem.title
                    
                }catch{
                    print(error)
                }
                group.leave()
            }
        }
        task.resume()
        group.wait()
        
        mensaje = mensajeTemp
        
        return
    }
    
    
    
    // Call
    func callAPILista() -> Array<Post> {
        
        // An initial array of Post type
        var listaPostsTemp : Array<Post> = []
        
        // Endpoint returns an array of posts now
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else{
            return listaPostsTemp
        }
        
        let group = DispatchGroup()
        group.enter()
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            let jsonDecoder = JSONDecoder()
            if (data != nil){
                do{
                    // Decode into an array of Post
                    // With .self, we access the metadata of [] when its of type Post
                    let postList = try jsonDecoder.decode([Post].self, from: data!)
                    
                    // Obtain each Post retrieved from the post array
                    for postItem in postList {
                        print("Id: \(postItem.id) - Titulo: \(postItem.title) ")
                    }
                    listaPostsTemp = postList
                }catch{
                    print(error)
                }
                group.leave()
            }
        }
        task.resume()
        group.wait()
        
        return listaPostsTemp
    }
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Button("Tap Me") {
                // API call with response in console
                listaPosts = callAPILista()
            }
            
            List(listaPosts) { item in
                Text(item.title)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
