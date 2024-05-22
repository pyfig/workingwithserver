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
            }
           .navigationTitle("Главная")
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
        VStack{
            List(self.posts, id: \.self) { item in
                HStack {
                    Text("UserId: \(item.userId)")
                    Text("Id: \(item.id)")
                    Text("Title: \(item.title)")
                    Text("Body: \(item.body)")
                }
            }
            
            Button("Получить данные с сервера"){
                AF
                    .request("https://jsonplaceholder.typicode.com/posts")
                    .responseDecodable(of: [AllPost].self){response in
                        if response.value != nil {
                            self.posts = response.value!
                        }//if
                    }//responseDecodable
            }//Button
        }//VStack
    }
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



