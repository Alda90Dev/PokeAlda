//
//  ListItemsViewModel.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 29/06/26.
//

import Combine

public final class ListItemsViewModel: ObservableObject {
    @Published public var items: [Pokemon] = []
    @Published public var isLoading: Bool = false
    public let loadMorePublisher = PassthroughSubject<Void, Never>()
    
    public func configure(with items: [Pokemon]) {
        self.items = items
    }
    
    public func loadMore() {
        self.loadMorePublisher.send()
    }
}
