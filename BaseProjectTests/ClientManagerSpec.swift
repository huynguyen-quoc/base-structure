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

            let url = URL(string: "http://test")
            var client: DefaultClientManager?
            context("After being properly initialized") {
                it("should have base url and user session") {
                    client = DefaultClientManager(baseURL: url!, session: URLSessionMock())
                    expect(client?.baseURL).toNot(beNil())
                    expect(client?.session).toNot(beNil())
                }

            }
            describe("get method") {
                context("After calling get method with success request and param") {

                    it("should return response 200 and with data ") {
                        client = DefaultClientManager(baseURL: url!, session: URLSessionMock())
                        let params:[String: String] = [
                            "test" : "test"
                        ]
                        client?.get(DecodableTest.self, endpoint: "/test", params: params, completion: { (result, response, error) in
                            expect(response).toNot(beNil())
                            if let httpResponse = response as? HTTPURLResponse {
                                expect(httpResponse.statusCode).to(equal(200))
                                expect(result?.id).to(equal("1"))
                            }

                        })
                    }
                }

                context("After calling get method with error request") {
                    it("should return response error code ") {
                        client = DefaultClientManager(baseURL: url!, session: URLSessionMockErrorWithData())
                        client?.get(DecodableTest.self, endpoint: "/test", params: nil, completion: { (result, response, error) in
                            expect(response).toNot(beNil())
                            expect(result).to(beNil())
                            expect(error).toNot(beNil())
                            if let httpResponse = response as? HTTPURLResponse {
                                expect(httpResponse.statusCode).to(equal(400))
                            }

                        })
                    }
                }

                context("After calling get method with error decoable") {
                    it("should return response error code ") {
                        client = DefaultClientManager(baseURL: url!, session: URLSessionMock())
                        client?.get(DecodableErrorTest.self, endpoint: "/test", params: nil, completion: { (result, response, error) in
                            expect(response).toNot(beNil())
                            if let httpResponse = response as? HTTPURLResponse {
                                expect(httpResponse.statusCode).to(equal(200))
                                expect(result).to(beNil())
                            }

                        })
                    }
                }
            }
            describe("post method") {
                context("After calling post method with success request") {
                    
                    it("should return response 200 and with data") {
                        client = DefaultClientManager(baseURL: url!, session: URLSessionMock())
                        let body:EncodableTest = EncodableTest(name: "test")
                        
                        client?.post(DecodableTest.self, endpoint: "/test", params: nil, body: body, completion:  { (result, response, error) in
                            expect(response).toNot(beNil())
                            if let httpResponse = response as? HTTPURLResponse {
                                expect(httpResponse.statusCode).to(equal(200))
                                expect(result?.id).to(equal("1"))
                            }
                        })
                    }
                }
            
            }
            
            describe("put method") {
                context("After calling post method with success request") {
                    
                    it("should return response 200 and with data") {
                        client = DefaultClientManager(baseURL: url!, session: URLSessionMock())
                        let body:EncodableTest = EncodableTest(name: "test")
                        
                        client?.put(DecodableTest.self, endpoint: "/test", params: nil, body: body, completion:  { (result, response, error) in
                            expect(response).toNot(beNil())
                            if let httpResponse = response as? HTTPURLResponse {
                                expect(httpResponse.statusCode).to(equal(200))
                                expect(result?.id).to(equal("1"))
                            }
                        })
                    }
                }
                
            }
            
            describe("delete method") {
                context("After calling post method with success request") {
                    it("should return response 200 and with data") {
                        client = DefaultClientManager(baseURL: url!, session: URLSessionMock())
                        
                        client?.delete(DecodableTest.self, endpoint: "/test", params: nil, completion:  { (result, response, error) in
                            expect(response).toNot(beNil())
                            if let httpResponse = response as? HTTPURLResponse {
                                expect(httpResponse.statusCode).to(equal(200))
                                expect(result?.id).to(equal("1"))
                            }
                        })
                    }
                }
                
            }
        }
    }

}

private struct DecodableTest: Decodable {
    let id: String
}

private struct DecodableErrorTest: Decodable {
    let id: Int
}

private struct EncodableTest: Encodable {
    let name:String
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
    var data: Data = "{\"id\" : \"1\" }".data(using: .utf8)!
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

private class URLSessionMockErrorWithData: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data = "{\"id\" : \"1\" }".data(using: .utf8)!
    var error: Error = NSError(domain: "test", code: 2022, userInfo: nil)

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}
