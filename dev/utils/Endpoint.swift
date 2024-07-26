import Foundation

class NetworkUrlConstant {
    static let searchFoodUrl : String = "search.php";
    static let lookupFullMealDetailUrl : String = "lookup.php";
    static let randomSingleMealUrl : String = "random.php";
    static let categoryUrl : String = "categories.php";
    static let foodListUrl : String = "list.php";
    static let foodListFilterUrl : String = "filter.php";
    
    static let loginUrl = "auth/login";
    static let signupUrl = "auth/create-account"
}

struct CustomEndpoint {
    var path: String
    var headers: [String: String] = ["Content-type": "application/json"]
    var queries: [String: String] = [:];
    
    init(path: String, headers: [URLQueryItem]?, queries: [String: String]?) {
        self.path = path
        self.queries = queries ?? [:]
    }
    
}

extension CustomEndpoint {
        var url: URL {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "www.themealdb.com"
            components.path = "/api/json/v1/1" + (path.hasPrefix("/") ? path : "/" + path)
            components.queryItems = self.queries.map { URLQueryItem(name: $0.key, value: $0.value) }
            
    
            guard let url = components.url else {
                preconditionFailure("Invalid URL components: \(components)")
            }
    
            return url
        }
    
    var urlMain: URL {
        var components = URLComponents()
        
        components.scheme = "http"
        components.host = "localhost"
        components.port = 3000
        components.path = (path.hasPrefix("/") ? path : "/" + path)
        components.queryItems = self.queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url;
    }
}
