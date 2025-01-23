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
