//
//  SuperHeroListInteractor.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import XCTest
@testable import ViperB

class SuperHeroListInteractorTests: XCTestCase {

    let expectationTimeout = 1.0
    var sut: SuperHeroListInteractor?
    let imageDataManager = ImageDataManagerMock()
    let dataManager = SuperHeroDataManagerMock()
    let mockDelegate = SuperHeroListInteractorDelegateMock()
    override func setUp() {
        super.setUp()
        sut = SuperHeroListInteractor(superHeroDataManager: dataManager, imageDataManager: imageDataManager)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoadAllSortedAlphabeticallySucceedWithCachedImage() {
        let expectation = XCTestExpectation(description: "expected correct result with imageDatas.")

        dataManager.failedToLoad = false
        imageDataManager.cachedImage = true

        sut?.loadAllSortedAlphabetically(completion: { (result) in
            switch result {
            case .success(let entities):
                XCTAssertNotNil(entities)
                XCTAssertFalse(entities.isEmpty)
                XCTAssertTrue(entities.first?.name.compare((entities.last?.name)!) == .orderedAscending)
                XCTAssertNotNil(entities.first?.imageData)
                expectation.fulfill()
                break
            default: break
            }
        })
        self.wait(for: [expectation], timeout: expectationTimeout)
    }

    func testLoadAllSortedAlphabeticallySucceedWithoutCachedImage() {
        let expectation = XCTestExpectation(description: "expected correct result without imageDatas.")

        dataManager.failedToLoad = false
        imageDataManager.cachedImage = false

        sut?.loadAllSortedAlphabetically(completion: { (result) in
            switch result {
            case .success(let entities):
                XCTAssertNotNil(entities)
                XCTAssertFalse(entities.isEmpty)
                XCTAssertTrue(entities.first?.name.compare((entities.last?.name)!) == .orderedAscending)
                XCTAssertNil(entities.first?.imageData)
                expectation.fulfill()
                break
            default: break
            }
        })
        self.wait(for: [expectation], timeout: expectationTimeout)
    }

    func testLoadAllSortedAlphabeticallyFailedWithLoadError() {
        let expectation = XCTestExpectation(description: "expected error result.")

        dataManager.failedToLoad = true

        sut?.loadAllSortedAlphabetically(completion: { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertTrue(error == SuperHeroListInteractorError.loadError)
                expectation.fulfill()
                break
            default: break
            }
        })
        self.wait(for: [expectation], timeout: expectationTimeout)
    }

    func testLoadTop10SucceedWithCachedImage() {
        let expectation = XCTestExpectation(description: "expected correct result with imageDatas.")

        dataManager.failedToLoad = false
        imageDataManager.cachedImage = true

        sut?.loadTop10(completion: { (result) in
            switch result {
            case .success(let entities):
                XCTAssertNotNil(entities)
                XCTAssertFalse(entities.isEmpty)
                XCTAssertTrue(entities.count == 10)
                XCTAssertTrue((entities.first?.rank)! < (entities.last?.rank)!)
                XCTAssertNotNil(entities.first?.imageData)
                expectation.fulfill()
                break
            default: break
            }
        })
        self.wait(for: [expectation], timeout: expectationTimeout)
    }

    func testLoadTop10SucceedWithoutCachedImage() {
        let expectation = XCTestExpectation(description: "expected correct result without imageDatas.")

        dataManager.failedToLoad = false
        imageDataManager.cachedImage = false

        sut?.loadTop10(completion: { (result) in
            switch result {
            case .success(let entities):
                XCTAssertNotNil(entities)
                XCTAssertFalse(entities.isEmpty)
                XCTAssertTrue(entities.count == 10)
                XCTAssertTrue((entities.first?.rank)! < (entities.last?.rank)!)
                XCTAssertNil(entities.first?.imageData)
                expectation.fulfill()
                break
            default: break
            }
        })
        self.wait(for: [expectation], timeout: expectationTimeout)
    }

    func testLoadTop10FailedWithLoadError() {
        let expectation = XCTestExpectation(description: "expected error result.")

        dataManager.failedToLoad = true

        sut?.loadAllSortedAlphabetically(completion: { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertTrue(error == SuperHeroListInteractorError.loadError)
                expectation.fulfill()
                break
            default: break
            }
        })
        self.wait(for: [expectation], timeout: expectationTimeout)
    }

    func testLoadImageSucceed() {
        imageDataManager.failedLoadImageError = nil
        let model = SuperHeroListModel(id: 0, name: "name", mightiness: .noob, rank: 10, imageUrl: "imageUrl", imageData: nil)
        sut?.delegate = mockDelegate

        sut?.loadImage(for: model)

        XCTAssertNotNil(mockDelegate.updatedModel)
        XCTAssertEqual(mockDelegate.updatedModel?.name, model.name)
        XCTAssertEqual(mockDelegate.updatedModel?.id, model.id)
        XCTAssertEqual(mockDelegate.updatedModel?.imageUrl, model.imageUrl)
        XCTAssertNotNil(mockDelegate.updatedModel?.imageData)
    }

    func testLoadImageWithCachedImage() {
        imageDataManager.failedLoadImageError = nil
        imageDataManager.cachedImage = true
        let model = SuperHeroListModel(id: 0, name: "name", mightiness: .noob, rank: 10, imageUrl: "imageUrl", imageData: nil)
        sut?.delegate = mockDelegate

        sut?.loadImage(for: model)

        XCTAssertNil(mockDelegate.updatedModel)
    }

    func testLoadImageWithExistedImageData() {
        imageDataManager.failedLoadImageError = nil
        imageDataManager.cachedImage = true
        let model = SuperHeroListModel(id: 0, name: "name", mightiness: .noob, rank: 10, imageUrl: "imageUrl", imageData: Data())
        sut?.delegate = mockDelegate

        sut?.loadImage(for: model)

        XCTAssertNil(mockDelegate.updatedModel)
    }

    func testLoadImageFailed() {
        imageDataManager.failedLoadImageError = ImageDataManagerError.noImageData
        let model = SuperHeroListModel(id: 0, name: "name", mightiness: .noob, rank: 10, imageUrl: "imageUrl", imageData: nil)
        sut?.delegate = mockDelegate

        sut?.loadImage(for: model)

        XCTAssertNil(mockDelegate.updatedModel)
    }
}
