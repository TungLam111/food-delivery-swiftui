import Foundation

class NetworkUrlConstant {
    static let searchFoodUrl : String = "search.php";
    static let lookupFullMealDetailUrl : String = "lookup.php";
    static let randomSingleMealUrl : String = "random.php";
    static let categoryUrl : String = "categories.php";
    static let foodListUrl : String = "list.php";
    static let foodListFilterUrl : String = "filter.php";
}

struct CustomEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension CustomEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.themealdb.com"
        components.path = "/api/json/v1/1" + (path.hasPrefix("/") ? path : "/" + path)
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: [String: String] {
        return ["Content-type": "application/json"]
    }
}
