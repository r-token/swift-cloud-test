//
//  main.swift
//  SwiftCloudTestAgain
//
//  Created by Ryan Token on 1/22/25.
//

import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation

// the data structure to represent the input parameter
struct HelloRequest: Decodable {
    let name: String
    let age: Int
}

// the data structure to represent the output response
struct HelloResponse: Encodable {
    let statusCode: Int = 200
    let headers: [String: String] = [
        "Content-Type": "application/json"
    ]
    let body: String
}

let runtime = LambdaRuntime { (event: APIGatewayV2Request, context: LambdaContext) -> APIGatewayV2Response in
    context.logger.info("Received request: \(event)")
    let body = try JSONDecoder().decode(HelloRequest.self, from: (event.body?.data(using: .utf8))!)
    let greeting = "Hello \(body.name). You look \(body.age > 30 ? "younger" : "older") than your age."

    return APIGatewayV2Response(
        statusCode: .ok,
        body: greeting
    )
}

try await runtime.run()
