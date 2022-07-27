import CoreData

class BookFolderViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedEntities: [BookEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "NoteDataModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }else{
                print("success")
            }
        }
        fetchBooks()
    }
    
    func fetchBooks() {
        
        let request = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
            
            print(savedEntities)
            
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addBook(title: String, author: String) {
        let newBook = BookEntity(context: container.viewContext)
        newBook.titleBook = title
        newBook.authorBook =  author
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchBooks()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}

//class BookModel: Identifiable, ObservableObject {
//    
//    private var book: BookEntity
//    
//    init (book : BookEntity) {
//        self.book = book
//    }
//    
////    var id: NSManagedObjectID {
////        book.objectID
////    }
//    var titleBook: String{
//        book.titleBook ?? ""
//        
//    }
//    var authorBook: String {
//        book.authorBook ?? ""
//    }
//    
//    var coverBook: String {
//        book.coverBook ?? ""
//        
//    }
//}
