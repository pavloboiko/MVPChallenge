//
//  Result.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//


import Foundation

 /// Result
public enum Result<V, E: Error> {
    case success(V)
    case failure(E)
}
