//
//  SuperHeroDetailsInteractorTests.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import XCTest
@testable import ViperB

class SuperHeroDetailsInteractorTests: XCTestCase {

    let expectationTimeout = 1.0
    var sut: SuperHeroDetailsInteractor?
    let imageDataManager = ImageDataManagerMock()
    let dataManager = SuperHeroDataManagerMock()
    let mockDelegate = SuperHeroDetailsInteractorDelegateMock()

    var superHeroEntity: SuperHeroEntityType {
        return SuperHeroEntity(id: 1,
                               name: "name 1",
                               punchQuote: "punchQuote 1",
                               mainSuperPower: "mainSuperPower 1",
                               imageUrl: "https://imageUrl/1",
                               mightiness: 1,
                               rank: 1,
                               bio: "bio 1")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoadSuperHeroDetailsSucceedWithCachedImage() {
        let expectation = XCTestExpectation(description: "expected correct result with imageData.")

        sut = SuperHeroDetailsInteractor(superHeroId: 1, superHeroDataManager: dataManager, imageDataManager: imageDataManager)
        dataManager.failedToLoad = false
        imageDataManager.cachedImage = true

        sut?.loadSuperHeroDetails(completion: { [weak self] (result) in
            switch result {
            case .success(let entity):
                XCTAssertNotNil(entity)
                XCTAssertEqual(entity.name, self?.superHeroEntity.name)
                XCTAssertNotNil(entity.imageData)
                expectation.fulfill()
                break
            default: break
            }
        })
        self.wait(for: [expectation], timeout: expectationTimeout)
    }

    func testLoadSuperHeroDetailsSucceedWithoutCachedImage() {
        let expectation = XCTestExpectation(description: "expected correct result without imageData.")

        sut = SuperHeroDetailsInteractor(superHeroId: 1, superHeroDataManager: dataManager, imageDataManager: imageDataManager)
        dataManager.failedToLoad = false
        imageDataManager.cachedImage = false

        sut?.loadSuperHeroDetails(completion: { [weak self] (result) in
            switch result {
            case .success(let entity):
                XCTAssertNotNil(entity)
                XCTAssertEqual(entity.name, self?.superHeroEntity.name)
                XCTAssertNil(entity.imageData)
                expectation.fulfill()
                break
            default: break
            }
        })
        self.wait(for: [expectation], timeout: expectationTimeout)
    }

    func testLoadSuperHeroDetailsSucceedAndDownloadImageSucceedWithoutCachedImage() {
        sut = SuperHeroDetailsInteractor(superHeroId: 1, superHeroDataManager: dataManager, imageDataManager: imageDataManager)
        sut?.delegate = mockDelegate
        dataManager.failedToLoad = false
        imageDataManager.cachedImage = false

        sut?.loadSuperHeroDetails(completion: { (result) in })
        XCTAssertNotNil(mockDelegate.updatedModel)
        XCTAssertEqual(mockDelegate.updatedModel?.name, superHeroEntity.name)
        XCTAssertEqual(mockDelegate.updatedModel?.imageUrl, superHeroEntity.imageUrl)
        XCTAssertNotNil(mockDelegate.updatedModel?.imageData)
        XCTAssertNotNil(mockDelegate.updatedModel?.bio)
    }

    func testLoadSuperHeroDetailsSucceedAndDownloadImageFailedWithoutCachedImage() {
        sut = SuperHeroDetailsInteractor(superHeroId: 1, superHeroDataManager: dataManager, imageDataManager: imageDataManager)
        sut?.delegate = mockDelegate
        dataManager.failedToLoad = false
        imageDataManager.cachedImage = false
        imageDataManager.failedLoadImageError = .invalidImageData

        sut?.loadSuperHeroDetails(completion: { (result) in })
        XCTAssertNil(mockDelegate.updatedModel)
    }

    func testLoadSuperHeroDetailsFailedWithLoadError() {
        let expectation = XCTestExpectation(description: "expected error result.")

        sut = SuperHeroDetailsInteractor(superHeroId: 1, superHeroDataManager: dataManager, imageDataManager: imageDataManager)
        dataManager.failedToLoad = true
        imageDataManager.cachedImage = false

        sut?.loadSuperHeroDetails(completion: { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertTrue(error == SuperHeroDetailsInteractorError.loadError)
                expectation.fulfill()
                break
            default: break
            }
        })
        self.wait(for: [expectation], timeout: expectationTimeout)
    }

    func testLoadSuperHeroDetailsFailedLoadErrorNoDetails() {
        let expectation = XCTestExpectation(description: "expected error result.")

        sut = SuperHeroDetailsInteractor(superHeroId: 200, superHeroDataManager: dataManager, imageDataManager: imageDataManager)
        dataManager.failedToLoad = false

        sut?.loadSuperHeroDetails(completion: { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertTrue(error == SuperHeroDetailsInteractorError.noDetails)
                expectation.fulfill()
                break
            default: break
            }
        })
        self.wait(for: [expectation], timeout: expectationTimeout)
    }
}
