import SwiftUI
import Alamofire


struct ContentView: View {
    var body: some View {
        NavigationView { // Use NavigationView to enable navigation
            List {
                NavigationLink(destination: AllPostView()) {
                    Text("Список постов")
                }
                
                NavigationLink(destination: AnotherDetailView()) {
                    Text("Мой последний пост")
                }
            }
           .navigationTitle("Главная")
        }
    }
}
struct AnotherDetailView: View {
        var body: some View {
            Text("Another Detail View")
                .font(.title)
                .padding()
        }
    }
struct AllPostView: View {
@State var posts: [AllPost] = []
var body: some View {
    VStack{
        List(self.posts, id: \.self) { item in
            HStack {
                Text("UserId: \(posts.userId)")
                Text("Id: \(posts.id)")
                Text("Title: \(posts.title??, "")")
                Text("Body: \(posts.body??, "")")
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
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
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



