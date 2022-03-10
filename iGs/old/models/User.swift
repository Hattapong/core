class User: Codable {
    let id, name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
