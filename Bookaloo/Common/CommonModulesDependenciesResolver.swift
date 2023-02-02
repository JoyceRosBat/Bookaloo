//
//  CommonModulesDependenciesResolver.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

protocol CommonModulesDependenciesResolver: BooksDependenciesResolver,
                                            ClientsDependenciesResolver,
                                            ShopDependenciesResolver {}
