import Foundation

public struct OrderedArray<T: Comparable> {
    fileprivate var array = [T]()

    public init(array: [T]) {
        self.array = array.sorted()
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

    public mutating func removeAtIndex(index: Int) -> T {
        return array.remove(at: index)
    }

    public mutating func removeAll() {
        array.removeAll()
    }

    /// This method will return the entry that is previous to the entry that was passed in.
    public func matchingOrPreviousToEntry(_ entry: T) -> T? {
        let i = findInsertionPoint(entry)
        if array[i] == entry {
            return array[i]
        }
        if i == 0 {
            if array[i] < entry {
                return array[i]
            } else {
                return nil
            }
        }
        return array[i - 1]
    }
    
    /// This method will return the entry that is after the entry that was passed in
    public func matchingOrLaterThanEntry(_ entry: T) -> T? {
        let i = findInsertionPoint(entry)
        guard i <= array.count - 1 else {
            return nil
        }
        return array[i]
    }
    
    public mutating func insert(_ newElement: T) -> Int {
        let i = findInsertionPoint(newElement)
        array.insert(newElement, at: i)
        return i
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
    private func findInsertionPoint(_ newElement: T) -> Int {
        var startIndex = 0
        var endIndex = array.count

        while startIndex < endIndex {
            let midIndex = startIndex + (endIndex - startIndex) / 2
            if array[midIndex] == newElement {
                return midIndex
            } else if array[midIndex] < newElement {
                startIndex = midIndex + 1
            } else {
                endIndex = midIndex
            }
        }
        return startIndex
    }
}

extension OrderedArray: CustomStringConvertible {
    public var description: String {
        return array.description
    }
}
