//
//  SnapshotExampleTests.swift
//  SnapshotExampleTests
//
//  Created by Mikko Välimäki on 2019-08-14.
//  Copyright © 2019 Mikko Välimäki. All rights reserved.
//

import XCTest
@testable import SnapshotExample
import SnapshotTesting

class SnapshotExampleTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testLabel() {
        let label = ImageLabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)

        UIContentSizeCategory.all.forEach { size in
            assertAutoLayoutSnapshot(
                matching: label,
                as: .image(traits: .init(preferredContentSizeCategory: size)),
                named: String(describing: size)
            )
        }
    }
}

extension UIContentSizeCategory {
    static let all: [UIContentSizeCategory] = [.extraSmall, .small, .medium, .large, .extraLarge, .extraExtraLarge, .extraExtraExtraLarge]
}
