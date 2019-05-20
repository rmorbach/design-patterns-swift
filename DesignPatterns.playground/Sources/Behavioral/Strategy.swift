import Foundation

public protocol MovieRatingStrategy {
    var ratingServiceName: String { get }
    
    func fetchRating(forMovieTitle movieTitle: String, success: (_ rating: Double, _ review: String) -> ())
}

public class SomeClientApi: MovieRatingStrategy {
    
    public let ratingServiceName = "SomeClientApi"

    public func fetchRating(forMovieTitle movieTitle: String, success: (_ rating: Double, _ review: String) -> ()) {
        // Some complex networking logic
        success(9.6, "Very good")
    }
}

public class RatingManager {
    let moviesRatingClient: MovieRatingStrategy
    
    public init(withClient client: MovieRatingStrategy) {
        self.moviesRatingClient = client
    }
    
    func fetchRating(forMovie movie: String) {
        let resultBlock: (Double, String) -> () = { rating, review in
            print(rating, review)
        }
        self.moviesRatingClient.fetchRating(forMovieTitle: movie, success: resultBlock)
    }
}

public func strategyExample() {
    let clientAPI = SomeClientApi()
    let ratingManager = RatingManager(withClient: clientAPI)
    ratingManager.fetchRating(forMovie: "Titanic")
}
