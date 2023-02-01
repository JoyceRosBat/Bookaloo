//
//  CommonDependenciesResolver.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

protocol CommonDependenciesResolver: NetworkDependenciesResolver,
                                     BooksDependenciesResolver,
                                     ClientsDependenciesResolver {}
