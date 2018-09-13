//
//  HomeTabCoordinator.swift
//  XCoordinator-Example
//
//  Created by Joan Disho on 04.05.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation
import XCoordinator

enum HomeRoute: Route {
    case news
    case userList
}

class HomeTabCoordinator: TabBarCoordinator<HomeRoute> {

    let newsCoordinator: AnyCoordinator<NewsRoute>
    let userListCoordinator: AnyCoordinator<UserListRoute>

    convenience init() {
        let newsCoordinator = NewsCoordinator()
        newsCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)

        let userListCoordinator = UserListCoordinator()
        userListCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        self.init(newsCoordinator: newsCoordinator.anyCoordinator,
                  userListCoordinator: userListCoordinator.anyCoordinator)
    }

    init(newsCoordinator: AnyCoordinator<NewsRoute>,
         userListCoordinator: AnyCoordinator<UserListRoute>) {
        self.newsCoordinator = newsCoordinator
        self.userListCoordinator = userListCoordinator

        super.init(tabs: [newsCoordinator, userListCoordinator], select: userListCoordinator)
    }

    override func prepareTransition(for route: HomeRoute) -> TabBarTransition {
        switch route {
        case .news:
            return .select(newsCoordinator)
        case .userList:
            return .select(userListCoordinator)
        }
    }
}