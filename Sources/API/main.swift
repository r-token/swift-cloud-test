//
//  main.swift
//  SwiftCloudTestAgain
//
//  Created by Ryan Token on 1/22/25.
//

import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation

// the data structure we'll decode out of the API response
struct HelloRequest: Decodable {
    let name: String
    let age: Int
}

struct HelloResponse: Encodable {
    let body: HelloBody
}

struct HelloBody: Encodable {
    let greeting: String
    let propertyTwo: Int
}

let runtime = LambdaRuntime { (event: APIGatewayV2Request, context: LambdaContext) -> APIGatewayV2Response in
    context.logger.info("Received request: \(event)")
    let eventBody = try JSONDecoder().decode(HelloRequest.self, from: (event.body?.data(using: .utf8))!)
    let greeting = "Hello \(eventBody.name). You look \(eventBody.age > 30 ? "younger" : "older") than your age."
    let responseBody = HelloResponse(body: HelloBody(greeting: greeting, propertyTwo: 100))
    let response = try JSONEncoder().encode(responseBody).base64EncodedString()

    return APIGatewayV2Response(
        statusCode: .ok,
        body: response,
        isBase64Encoded: true
    )
}

try await runtime.run()
