
import UIKit
import PlaygroundSupport

/// Classic simple TreeNode class
class TreeNode: Hashable {
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.left == rhs.left && rhs.right == lhs.right && lhs.val == rhs.val
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
    }
    else {
        let l = dfs(node?.left, target, k, &ans)
        let r = dfs(node?.right, target, k, &ans)
        
        if l != -1 {
            if l == k, let nodeValue = node?.val {
                ans.append(nodeValue)
            }
            subtreeAdd(node?.right, l+1, k, &ans)
            return l+1
        }
        else if r != -1 {
            if r == k, let nodeValue = node?.val {
                ans.append(nodeValue)
            }
            subtreeAdd(node?.left, r+1, k, &ans)
            return r+1
        }
        else {
            return -1
        }
    }
    
}

func subtreeAdd(_ node: TreeNode?, _ dist: Int, _ k: Int, _ ans: inout [Int]) {
    guard let node = node else { return }
    // found our node
    if dist == k {
        ans.append(node.val)
    }
    else {
        subtreeAdd(node.left, dist+1, k, &ans)
        subtreeAdd(node.right, dist+1, k, &ans)
    }
}





//class Solution {
//
//    func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ K: Int) -> [Int] {
//        var ans: [Int] = []
//        dfs_V2(root, target, K, &ans)
//        return ans
//    }
//
//    func dfs_V2(_ node: TreeNode?, _ target: TreeNode?, _ k: Int, _ ans: inout [Int]) -> Int {
//        if node == nil {
//            return -1
//        }
//        else if node?.val == target?.val {
//            subtreeAdd(node, 0, k, &ans)
//            return 1
//        }
//        else {
//            let l = dfs_V2(node?.left, target, k, &ans)
//            let r = dfs_V2(node?.right, target, k, &ans)
//
//            if l != -1 {
//                if l == k, let nodeValue = node?.val {
//                    ans.append(nodeValue)
//                }
//                subtreeAdd(node?.right, l + 1, k, &ans)
//                return l + 1
//            }
//            else if r != -1 {
//                if r == k, let nodeValue = node?.val {
//                    ans.append(nodeValue)
//                }
//                subtreeAdd(node?.left, r + 1, k, &ans)
//                return r + 1
//            }
//            else {
//                return -1
//            }
//        }
//    }
//
//    func subtreeAdd(_ node: TreeNode?, _ dist: Int, _ k: Int, _ ans: inout [Int]) {
//        guard let node = node else { return }
//        if dist == k {
//            ans.append(node.val)
//        }
//        else {
//            subtreeAdd(node.left, dist+1, k, &ans)
//            subtreeAdd(node.right, dist+1, k, &ans)
//        }
//    }
//}
