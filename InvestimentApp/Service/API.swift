//
//  API.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

protocol APIService {
    func getInvestiment(params: [String: Any],
                        onComplete:@escaping(Investiment) -> Void,
                        onError:@escaping(Error?) -> Void)
}

class API: APIService {

    func getInvestiment(params: [String: Any],
                        onComplete: @escaping (Investiment) -> Void,
                        onError: @escaping (Error?) -> Void) {

        let request = createRequest(with: params)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in

            if error == nil {
                guard let data = data else { return }
                guard let dictJson = self.parseDataToDictionary(data) else {
                    onError(nil)
                    return
                }
                guard let model = try?
                    JSONDecoder().decode(Investiment.self,
                    from: JSONSerialization.data(withJSONObject: dictJson, options: .prettyPrinted)) else {
                    onError(nil)
                    return
                }
                onComplete(model)
            } else {
                onError(error!)
            }
        }
        dataTask.resume()
    }

    private func parseDataToDictionary(_ data: Data) -> [String: Any]? {

        if let dictJson = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return dictJson
        }
        return nil
    }

    private func createRequest(with params: [String: Any]) -> URLRequest {
        let urlString = Endpoint.baseUrl
        let urlComponents = URLComponents(string: urlString)
        var items = [URLQueryItem]()

        for (key, value) in params {
            items.append(URLQueryItem(name: key, value: String(describing: value)))
        }

        if var urlComponents = urlComponents {
            urlComponents.queryItems = items
            if let url = urlComponents.url {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "GET"
                return urlRequest
            }
        }

        return URLRequest(url: URL(string: "")!) //should never return
    }

}
