<!--
Creator: Alex White
Market: SF
-->

![](https://ga-dash.s3.amazonaws.com/production/assets/logo-9f88ae6c9c3871690e33280fcf557f33.png)

# Big O and optimization with String Pattern Matching Part 2

### Why is this important?
*This workshop is important because:*

- Big O notation is a common way to describe the efficiency of an algorithm.
- It is an important concept in Computer Science
- It is a common concept in interviews
- Every programmer need to be able to think about optimization
- We use string matching algorithms every day

### What are the objectives?
*After this workshop, developers will be able to:*
- Understand and discuss some powerful optimizations for string matching

### Where should we be now?
*Before this workshop, developers should already be able to:*

- Analyze the *time* Big O of various algorithms
- Implement a Brute Force solution to the string matching problem
- Think about performance optimization

## Optimize
![](http://i.giphy.com/o5sriskD98REc.gif)

### How can we make our brute force algorithm go faster?

Discuss with your table some optimizations to share with the class.


#### Eliminate Repeated and Useless Work

There are only so many things we can do to make things run faster. One is to eliminate any repeated or useless work. Our current brute force algorithm does a LOT of both.

- Useless work:

  When the first letter of our pattern doesn't match the current letter of our string, we already know we don't have a match. But our brute force algorithm doesn't care or notice! It keeps checking the rest of the pattern anyway.
- Repeated work:
  Repeated work occurs when we check something, forget it, only to check it again later. For example, we should save our pattern length in a variable once, rather than checking the length every time we need to know. What does this mean?

#### Space Time Tradeoff

  In computer science, we don't get stuff for free. Often the only way to optimize something is to trade some space for time. In other words, we trade the time it takes to calculate the length of our pattern for the space it takes to save that number in memory.

  We soon will look at some more complex optimizations that use this tradeoff in clever ways to make this algorithm run faster.

#### Boyer Moore/ Harspool

Simplified 'Bad Match Table':

The Boyer Moore algorithm trades space for time by saving a hash of all characters in the pattern. Instead of checking from right to left in the pattern, we go left to right.

Our simplified table just has the characters in our string as keys, and `true` as values. If the character is not in the hash, we can skip ahead by the length of the pattern.

if a pattern is "hello" our table will look like this:
```ruby
{'h' => true, 'e' => true, 'l' => true, 'o' => true}
```

![](http://3.bp.blogspot.com/-0sK816i32wU/TbeqFz-WlTI/AAAAAAAAADU/TMNE_-79A8A/s1600/BoyerMooreStandard.jpg)

Full Bad Match Table:

The full table uses the same concept as above, except it also optimizes for characters that **are** in our pattern. Instead of skipping ahead by the length of our pattern, we move ahead to match the character in our string where we are to a character in our pattern that **does** match.

These get constructed by giving them the value of the length of the pattern - the index of the letter - 1. Characters that ARE in the pattern get a value of the pattern's length instead of simply true. So if a pattern is "hello", and our alphabet is simply a-z, our table will look like this:

```ruby
{'a' => 5,
 'b' => 5,
 'c' => 5,
 'd' => 5,
 'e' => 3,
 'f' => 5,
 'g' => 5,
 'h' => 4,
 'i' => 5,
 'j' => 5,
 'k' => 5,
 'l' => 1,
 'm' => 5,
 'n' => 5,
 'o' => 5,
 'p' => 5,
 'q' => 5,
 'r' => 5,
 's' => 5,
 't' => 5,
 'u' => 5,
 'v' => 5,
 'w' => 5,
 'x' => 5,
 'y' => 5,
 'z' => 5}
```

[The Good Suffix Table](https://www.youtube.com/watch?v=lkL6RkQvpMM):

Taking this even further the good suffix table can make use of previous matches. Let's check out the video.

#### Big O of These Algorithms

Our **brute force** algorithm was O(n * m) time and O(1) space.

Big O for space is calculated by looking at the total size of any saved variables as compared to the inputs.

In our brute force we only save two variables, both of which are integers. These do not increase in relation to our inputs, which gives us constant time.

**Boyer Moore / Harspool** has the same time complexity as brute force with O(n * m), but it is much less likely be worst case scenario in the real world, while our brute-force hits this worst case regularly.


<details>
  <summary>How can we calculate the space complexity without the good suffix table?
</summary>
  <br>
  <p>We know our algorithm forms a table that will contain the number of characters in our alphabet. Therefore our space complexity is O(1), or constant.</p>
</details>
  <br>

**Boyer Moore** ALSO includes a **further** optimization called the Galil rule. This trades more time for space and remembers all matches and where they occured, so it never has to check the same letter twice. This results in O(n + m) time complexity, which is remarkably efficient. The implementation of this is beyond the scope of this lesson. 

## Closing Thoughts
- You can optimize an algorithm by eliminating useless or duplicate work, or by trading time for space.
- People work really hard collaborating over decades to create remarkably optimized algorithms.
- Big O space is calculated by looking at the length of anything saved in variables in an algorithm relation to its inputs.

## Additional Resources
- [KMP (another powerful optimization) explained](https://www.youtube.com/watch?v=2ogqPWJSftE)
- [Big O explained](https://www.interviewcake.com/article/java/big-o-notation-time-and-space-complexity)
