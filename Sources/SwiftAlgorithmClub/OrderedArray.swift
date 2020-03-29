import Foundation

public struct OrderedArray<T: Comparable>: Equatable {
    public enum Match {
        case exactonly
        case previous
        case after
    }
    
    fileprivate var array = [T]()
    fileprivate var allowDuplicates: Bool
    
    public init(allowDuplicates: Bool = true) {
        self.init(array: [], allowDuplicates: allowDuplicates)
    }
    
    public init(array: [T], allowDuplicates: Bool = true) {
        self.array = array.sorted()
        self.allowDuplicates = allowDuplicates
    }

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count
    }

    public subscript(index: Int) -> T {
        return array[index]
    }
    
    public mutating func remove(_ item: T) -> T? {
        let (_, i) = findInsertionPoint(item)
        guard array[i] == item else {
            return nil
        }
        return array.remove(at: i)
    }

    public mutating func removeAtIndex(_ index: Int) -> T {
        return array.remove(at: index)
    }

    public mutating func removeAll() {
        array.removeAll()
    }

    /// This method will return the entry that is previous to the entry that was passed in.
    public subscript(index: T, match: Match) -> T? {
        let (exists, i) = findInsertionPoint(index)
        if exists {
            return array[i]
        }
        switch(match) {
        case .exactonly:
            break
        case .previous:
            guard i != 0 else {
                if array[i] < index {
                    return array[i]
                } else {
                    return nil
                }
            }
            return array[i - 1]
        case .after:
            guard i <= array.count - 1 else {
                return nil
            }
            return array[i]
        }
        return nil
    }
    
    public mutating func insert(_ newElement: T) -> (existing: Bool, index: Int) {
        let (existing, i) = findInsertionPoint(newElement)
        if !existing || existing && allowDuplicates {
            array.insert(newElement, at: i)
        }
        return (existing: existing, index: i)
    }

    /*
    // Slow version that looks at every element in the array.
    private func findInsertionPoint(newElement: T) -> Int {
    for i in 0..<array.count {
      if newElement <= array[i] {
        return i
      }
    }
    return array.count
    }
    */

    // Fast version that uses a binary search.
    private func findInsertionPoint(_ newElement: T) -> (exists: Bool, index: Int) {
        var startIndex = 0
        var endIndex = array.count

        while startIndex < endIndex {
            let midIndex = startIndex + (endIndex - startIndex) / 2
            if array[midIndex] == newElement {
                return (exists: true, index: midIndex)
            } else if array[midIndex] < newElement {
                startIndex = midIndex + 1
            } else {
                endIndex = midIndex
            }
        }
        return (exists: false, index: startIndex)
    }
}

extension OrderedArray: CustomStringConvertible {
    public var description: String {
        return array.description
    }
}
