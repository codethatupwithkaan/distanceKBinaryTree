import UIKit
import PlaygroundSupport

/// Classic simple TreeNode class
class TreeNode: Hashable {
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
    
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(left)
        hasher.combine(right)
    }
}

let distanceK = UIImage(named: "sketch0.png")
/// Given a binary tree with Root, and a Target node. Find all the nodes that are K distance away from the Target node.
///             3
///           /    \
///          5       1
///         / \      / \
///        6  2     0   8
///          / \
///         7   4

let new8tree = TreeNode(8)
let new0tree = TreeNode(0)
let new1tree = TreeNode(1)
let new4tree = TreeNode(4)
let new6tree = TreeNode(6)
let new7tree = TreeNode(7)
let new2tree = TreeNode(2)
let new5tree = TreeNode(5)
let new3tree = TreeNode(3)

new3tree.left = new5tree
new3tree.right = new1tree
new5tree.left = new6tree
new5tree.right = new2tree
new2tree.left = new7tree
new2tree.right = new4tree
new1tree.left = new0tree
new1tree.right = new8tree

func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ K: Int) -> [Int] {
    var answer: [Int] = []
    dfs(root, target, K, &answer)
    return answer
}

/// Helper function for distanceK
/// - Parameters:
///   - node: root node
///   - target: target node
///   - k: steps/distance from target node
///   - ans: Array of Int's
/// - Returns: -1 if no nodes found, otherwise iterate on distance
func dfs(_ node: TreeNode?, _ target: TreeNode?, _ k: Int, _ ans: inout [Int]) -> Int {
    if node == nil {
        return -1
    }
    else if node?.val == target?.val {
        subtreeAdd(node, 0, k, &ans)
        return 1
    }
    else {
        let l = dfs(node?.left, target, k, &ans)
        let r = dfs(node?.right, target, k, &ans)
        
        if l != -1 {
            if l == k, let nodeValue = node?.val {
                ans.append(nodeValue)
            }
            subtreeAdd(node?.right, l + 1, k, &ans)
            return l + 1
        }
        else if r != -1 {
            if r == k, let nodeValue = node?.val {
                ans.append(nodeValue)
            }
            subtreeAdd(node?.left, r + 1, k, &ans)
            return r + 1
        }
        else {
            return -1
        }
    }
}

func subtreeAdd(_ node: TreeNode?, _ dist: Int, _ k: Int, _ ans: inout [Int]) {
    guard let node = node else { return }
    if dist == k {
        ans.append(node.val)
    }
    else {
        subtreeAdd(node.left, dist+1, k, &ans)
        subtreeAdd(node.right, dist+1, k, &ans)
    }
}

distanceK(new3tree, new5tree, 2)    // Should print [7, 4, 1]




class Solution {

    public func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ k: Int) -> [Int?] {
        guard let root = root, let target = target else { return [] }
        
        var parents: [TreeNode?: TreeNode?] = [:]
        dfs(root, nil, parents: &parents) // populate the parents
        
        var distance = 0
        var visited: [TreeNode?: TreeNode?] = [:]
        var queue: [TreeNode?] = []
        
        queue.append(nil)
        queue.append(target)
        
        visited[target] = target
        
        while !queue.isEmpty {
            let current = queue.removeFirst()
            
            if current == nil {
                if distance == k {
                    var answer: [Int?] = []
                    for n in queue {
                        answer.append(n?.val)
                    }
                    return answer
                }
                queue.append(nil)
                distance += 1
            }
            else {
                // We haven't visited this left Tree before
                if visited[current?.left] == nil {
                    visited[current?.left] = current?.left
                    queue.append(current?.left)
                }
                // We haven't visited this right Tree before
                if visited[current?.right] == nil {
                    visited[current?.right] = current?.right
                    queue.append(current?.right)
                }
                // We haven't visited this parent of current node before
                if let parentNode = parents[current], visited[parentNode] == nil {
                    visited[parentNode] = parentNode
                    queue.append(parentNode)
                }
            }
        }
        return []
    }
    
    func dfs(_ node: TreeNode?, _ parent: TreeNode?, parents: inout [TreeNode?: TreeNode?]) {
        if let par = parent, let node = node {
            parents[node] = par
        }
        if let node = node {
            dfs(node.left, node, parents: &parents)
            dfs(node.right, node, parents: &parents)
        }
    }
}
