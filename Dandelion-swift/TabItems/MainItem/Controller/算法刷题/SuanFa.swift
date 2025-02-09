//
//  SuanFa.swift
//  Dandelion-swift
//
//  Created by 窝窝头 on 2023/11/1.
//

import UIKit

class SuanFa: NSObject {

    /**
     给你一个整数数组 nums ，另给你一个整数 original ，这是需要在 nums 中搜索的第一个数字。
     
     接下来，你需要按下述步骤操作：

     如果在 nums 中找到 original ，将 original 乘以 2 ，得到新 original（即，令 original = 2 * original）。
     否则，停止这一过程。
     只要能在数组中找到新 original ，就对新 original 继续 重复 这一过程。
     返回 original 的 最终 值。
     [1,2,3,4,8,19,24,48] 输出16
     */
    func findFinalValue(_ nums: [Int], _ original: Int) -> Int {
        var newNum = original
        for num in nums {
            if num == original {
                newNum = findFinalValue(nums, original*2)
            }
        }
        return newNum
    }
    
    /**
     给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。

     你可以按任意顺序返回答案。
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
       
        var dic = Dictionary<Int, Int>()
        var indexs: [Int] = []
        for i in (0...nums.count-1) {
            if (dic.keys.contains(target-nums[i])) {
                indexs = [dic[target-nums[i]]!,i]
            } else {
                dic[nums[i]] = i
            }
        }
        return indexs
    }
    // 暴力枚举
    func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
       
        var indexs: [Int] = []
        for i in (0...nums.count-2) {
            for j in (i+1...nums.count-1) {
                if nums[i] + nums[j] == target {
                    indexs = [i,j]
                }
            }
        }
        return indexs
    }
    
    /**
      编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。
      不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
     */
    func reverseString(_ s: inout [Character]) {
        for i in (0...s.count-1) {
            if i < s.count-1-i {
                s.swapAt(i, s.count-1-i)
            } else {
                break
            }
        }
    }
    
    /**
     给你一个整数 x ，如果 x 是一个回文整数，返回 true ；否则，返回 false 。

     回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。

     例如，121 是回文，而 123 不是。
     */
    func isPalindrome(_ x: Int) -> Bool {
        return true
    }
}
