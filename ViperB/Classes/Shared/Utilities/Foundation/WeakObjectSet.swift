//
//  WeakReference.swift
//  NetsWhitelabelWalletApp
//
//  Created by Lukasz Marcin Margielewski on 19/10/2016.
//  Copyright © 2016 Unwire. All rights reserved.
//

import Foundation


// MARK: WeakObject

/// Internal / private wrapper around weak reference.
/// Used by WeakObjectSet to be able to simulate weak referenced collection.
fileprivate class WeakObject<T: AnyObject>: Equatable, Hashable {
    weak var object: T?
    private let objectHash: Int
    init(_ object: T) {
        self.object = object
        let pointer = Unmanaged.passUnretained(object).toOpaque()
        self.objectHash = pointer.hashValue
    }

    var hashValue: Int {
        return objectHash
    }
}


// MARK: WeakObject Equatable

/// Internal Equatable implementation for WeakObject to be able to implement `contain` and other operations on our WeakObjectSet.
fileprivate func == <T> (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
    return lhs.object === rhs.object
}


// MARK: WeakObjectSet

/// A set supporting weak references.
class WeakObjectSet<T: AnyObject> {
    private var objects: Set<WeakObject<T>>

    init() {
        self.objects = Set<WeakObject<T>>([])
    }

    init(objects: [T]) {
        self.objects = Set<WeakObject<T>>(objects.map { WeakObject($0) })
    }

    var all: [T] {
        return objects.flatMap { $0.object }
    }

    func contains(_ object: T) -> Bool {
        return self.objects.contains(WeakObject(object))
    }

    func add(_ object: T) {
        self.objects.formUnion([WeakObject(object)])
    }

    func add(objects: [T]) {
        self.objects.formUnion(objects.map { WeakObject($0) })
    }

    func remove(_ object: T) {
        // This prevents from 'is deallocating' crashes.
        let pointer = Unmanaged.passUnretained(object).toOpaque()
        let hash = pointer.hashValue
        let i = self.objects.index { (object) -> Bool in
            let objectHash = object.hashValue
            let match = objectHash == hash ? true : false
            return match
        }
        guard let index = i else { return }
        self.objects.remove(at: index)
    }
}
