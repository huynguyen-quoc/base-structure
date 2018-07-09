//
//  ClientManagerSpec.swift
//  BaseProjectTests
//
//  Created by Nguyen Quoc Huy on 7/9/18.
//  Copyright © 2018 Nguyen Quoc Huy. All rights reserved.
//

import Quick
import Nimble
@testable import BaseProject

class ClientManagerSpec: QuickSpec {
    
    override func spec() {
        describe("Client Manager") {
            
            let url = URL(string : "http://test")
            let client : UserClientManager = UserClientManager(baseURL: url!, session: URLSessionMock())
            
            context("After being properly initialized") {
                
                it("should have base url and user session") {
                    expect(client.baseURL).toNot(beNil())
                    expect(client.session).toNot(beNil())
                }
                
            }
            
            context("After calling get method with success request") {
                it("should return response 200") {
                    client.get(DecodableTest.self, endpoint: "/test", params: nil, completion: { (result, response, error) in
                        expect(response).toNot(beNil())
                        if let httpResponse = response as? HTTPURLResponse {
                            expect(httpResponse.statusCode).to(equal(200))
                        }
                        
                    })
                }
            }
        }
    }
    
}

private struct DecodableTest: Decodable {
    
}

private struct EncodableTest: Encodable {
    
}

private class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}

private class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}
