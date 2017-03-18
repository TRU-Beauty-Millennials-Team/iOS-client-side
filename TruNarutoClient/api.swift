
/*
 File contains all API methods in the app.
 */

import Foundation

/*

 */
class NarutoGeographyAPI {

    /*public static func getCountries() {
        let params = [""]
        Server.sendRequest(parameters: [""]);
    }*/

}

class NarutoCharactersAPI {

    public static func getCharacterList(page: Int, onComplite: @escaping (Data?, URLResponse?, Error?) -> Void) {

        Server.sendRequest(pathURL: "characters", parameters: ["page": "\(page)" as AnyObject], completionHandler: onComplite)
        
    }

    public static func getCharacter(name: String, onComplite: @escaping (Data?, URLResponse?, Error?) -> Void) {

        Server.sendRequest(pathURL: "character", parameters: ["name": name as AnyObject], completionHandler: onComplite)
        
    }

}
