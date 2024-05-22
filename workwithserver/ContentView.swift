import SwiftUI
import Alamofire


struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: AllPostView()) {
                    Text("Список постов")
                }
                
                NavigationLink(destination: OnePostView()) {
                    Text("Мой последний пост")
                }
                NavigationLink(destination: FindAllPosts()) {
                    Text("Поиск постов")
                }
            }
           .navigationTitle("Главная")
        }
    }
}
//struct AllPost: Decodable,Hashable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}
//struct OnePost: Codable,Hashable{
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}
struct FindAllPosts: View {
    @State private var onePost: AllPost? = nil
    @State private var input: String = ""
    
    var body: some View {
        VStack {
            if let post = onePost {
                VStack {
                    Text("User ID: \(post.userId)")
                    Text("ID: \(post.id)")
                    Text("Title: \(post.title)")
                    Text("Body: \(post.body)")
                }
            }
            TextField("Введите номер поста", text: $input)
               .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                AF.request("https://jsonplaceholder.typicode.com/posts/\(input)")
                   .responseDecodable(of: AllPost.self) { response in
                        switch response.result {
                        case.success(let post):
                            self.onePost = post
                        case.failure(_):
                            print("Error")
                        }
                    }
            }) {
                Text("Поиск")
                   .font(.headline)
                   .foregroundColor(.white)
                   .padding(10)
                   .background(Color.blue)
                   .cornerRadius(5)
            }
        }
    }
}
struct OnePostView: View {
    @State var post: OnePost? = nil
    var body: some View {
        VStack{
            if post != nil {
                 HStack {
                    Text("UserId: \(post!.userId)")
                    Text("Id: \(post!.id)")
                    Text("Title: \(post!.title)")
                    Text("Body: \(post!.body)")
                }
            }
            Button("Последний пост"){
                AF
                    .request("https://jsonplaceholder.typicode.com/posts/1")
                    .responseDecodable(of: OnePost.self) {response in
                        if response.value != nil {
                            self.post = response.value
                        }}
            }
        }
    }
}
struct AllPostView: View {
    @State var posts: [AllPost] = []

    var body: some View {
        VStack {
            List(self.posts, id: \.self) { item in
                HStack {
                    Text("UserId: \(item.userId)")
                    NavigationLink(destination: PostScreen(userId: item.userId, title: item.title, telo: item.body)){Text("показать")
                    }
                }
            }
        }
       .onAppear(perform: loadData)
    }
    func loadData() {
        AF.request("https://jsonplaceholder.typicode.com/posts")
           .responseDecodable(of: [AllPost].self) { response in
                if let value = response.value {
                    self.posts = value
                }
            }
    }
}
struct PostScreen: View {
    let userId: Int
    let title: String
    let telo: String
    var body: some View {
        VStack{
            Text("User id: \(userId)")
            Text("Title:\(title)")
            Text("Body:\(telo)")
        }
    }
}

#Preview {
    ContentView()
}
//struct DetailView: View {
//    var body: some View {
//        NavigationView {
//            NavigationLink(destination: AllPostsView()) {
//                Text("Загрузить")
//                    .font(.title)
//                    .padding()
//            }
//                
//        }
//    }
//}



//struct AllPostsView: View {
//    @State var posts: AllPost? = nil
//    
//    var body: some View {
//        if posts != nil {
//            VStack{
//                Text("UserId:\(posts!.userId)")
//                Text("Id:\(posts!.id)")
//                Text("Title:\(posts!.title)")
//                Text("Body:\(posts!.body)")
//            }
//        }
//        Button(action: { AF
//            .request("https://jsonplaceholder.typicode.com/posts")
//            .responseDecodable(of: AllPost.self) { response in
//                if response.value != nil {
//                    self.posts = response.value!
//                }
//            }
//        }){
//            Text("Загрузить")
//                .multilineTextAlignment(.center)
//        }
//    }
//}



//func FindById(id: Int) {
//    AF.request("https://jsonplaceholder.typicode.com/posts/\(id)")
//        .responseDecodable(of: (of: OnePost.self) { response in
//            if let post = response.value {
//                DispatchQueue.main.async {
//                    self.foundPost = post
//                }
//            }
//        }
//
//                           }
