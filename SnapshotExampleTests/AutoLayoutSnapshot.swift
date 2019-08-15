//
//  AutoLayoutSnapshot.swift
//  SnapshotExampleTests
//
//  Created by Mikko Välimäki on 2019-08-15.
//  Copyright © 2019 Mikko Välimäki. All rights reserved.
//

import XCTest
import UIKit
import SnapshotTesting

public func assertAutoLayoutSnapshot(
    matching value: @autoclosure () throws -> UIView,
    with traitCollection: UITraitCollection = UITraitCollection(),
    as snapshotting: Snapshotting<UIView, UIImage>,
    named name: String? = nil,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
    ) {

    guard let resizedView = try? value() else {
        XCTFail("Failed to obtain view.", file: file, line: line)
        return
    }

    // resize view using Auto Layout
    do {
        /// A simple view that supports override the trait collection from outside.
        class ContainerView: UIView {
            var overrideTraitCollection: UITraitCollection = UITraitCollection()
            override var traitCollection: UITraitCollection { return overrideTraitCollection }
        }

        // create a dummy view as a layout container
        let container = ContainerView()
        container.overrideTraitCollection = traitCollection
        container.addSubview(resizedView)
        resizedView.translatesAutoresizingMaskIntoConstraints = false
        resizedView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        resizedView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true

        // perform layout
        container.setNeedsLayout()
        container.layoutIfNeeded()

        // remove from the view hierarchy
        resizedView.removeFromSuperview()
    }

    let failure = verifySnapshot(
        matching: resizedView,
        as: snapshotting,
        named: name,
        record: recording,
        timeout: timeout,
        file: file,
        testName: testName,
        line: line
    )
    guard let message = failure else { return }
    XCTFail(message, file: file, line: line)
}

