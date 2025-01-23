//
//  Project.swift
//  SwiftCloudTestAgain
//
//  Created by Ryan Token on 1/22/25.
//

import Cloud

@main
struct SwiftCloudDemo: AWSProject {
    func build() async throws -> Outputs {
        let function = AWS.Function(
            "swift-lambda-2",
            targetName: "API",
            url: .enabled(cors: false)
        )

        return Outputs([
            "swift-lambda-function-url": function.url,
        ])
    }
}
