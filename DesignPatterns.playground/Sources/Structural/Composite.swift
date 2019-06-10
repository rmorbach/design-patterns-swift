import Foundation

// Component Protocol
protocol File {
    var name: String { get set }
    func open()
}

// Leaf
struct Book: File {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func open() {
        print("Opening book \(name)")
    }
}

// Leaf
struct Music: File {
    var name: String
    let album: String
    
    init(name: String, album: String) {
        self.name = name
        self.album = album
    }
    
    func open() {
        print("Opening music \(name) from album \(album)")
    }
}

// Component
final class Folder: File {
    
    var name: String
    lazy var files: [File] = []
    
    init(withName name: String) {
        self.name = name
    }
    
    func add(_ file: File) {
        files.append(file)
    }
    
    func open() {
        print("Displaying files from \(name)...")
        files.forEach {
            print($0.name)
        }
    }
}

extension Folder: Sequence {
    func makeIterator() -> ArraySlice<File>.Iterator {
        return files[0..<files.count].makeIterator()
    }
}

public func compositeExample() {
    
    let novemberRain = Music(name: "November Rain", album: "Appetite for Destruction")
    let dontCry = Music(name: "Don't cry", album: "Use your illusion I")
    
    let guns = Folder(withName: "Guns")
    guns.add(novemberRain)
    guns.add(dontCry)
    
    let davinciCode = Book(name: "The Da Vinci code")
    let manAndSea = Book(name: "The old man and the sea")
    
    let books = Folder(withName: "Classics")
    books.add(davinciCode)
    books.add(manAndSea)
    
    let musics = Folder(withName: "Musics")
    musics.add(guns)
    
    let misc = Folder(withName: "Misc")
    misc.add(books)
    misc.add(musics)
    
    misc.open()
    
}
