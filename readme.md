<!--
Creator: JP Barela
Market: Den
-->

![](https://ga-dash.s3.amazonaws.com/production/assets/logo-9f88ae6c9c3871690e33280fcf557f33.png)

# Big O and optimization with String Pattern Matching 

### Why is this important?
*This workshop is important because:*

- Big O notation is a common way to describe the efficiency of an algorithm.
- It is an important concept in Computer Science
- It is a common concept in interviews
- Every programmer need to be able to think about optimization
- We use string matching algorithms every day

### What are the objectives?
*After this workshop, developers will be able to:*

- Analyze the *time* Big O of various algorithms
- Implement a Brute Force solution to the string matching problem
- Identify the basic concepts behind the Harspool string matching algorithm

### Where should we be now?
*Before this workshop, developers should already be able to:*

- Write algorithms to solve simple problems
- Pseudo Code

## String Matching

### Ever wonder how `Command F` search works?

It works by using a **string matching** algorithm. The program you're using a browser, the terminal, Microsoft Word
treats all of the text as one long string, and looks for some pattern in that string. When it finds the pattern it stores the 
`index` of each instance of the pattern, and then uses highlights each instance of the pattern.

Underneath this lies an algorithm that searches through the text looking for the pattern.

How might that work?

### Big O Review

What's Big(O)? 

<details>
Big O is way to judge the efficiency of algorithms. By looking at what happens when the input is very large and focusing on 
the magnitude of the operations we can compare different algorithms.
</details>

What are some common Big(O) values?
<details>
- Constant
- ``ln n``
- ``n``
- ``n ln n``
- ``n^2``
</details>

A couple of additional considerations when we're talking about Big(O). 

We typically talk about about Big O in terms of operations because operations were historically the bottle neck. Operations 
are still typically the bottleneck but sometimes we want to talk about the Big O of the size of the input. As part of an 
algorithm do we use substantially more or less space to compute the answer.

Another idea is that Big O without a qualifier is refers to the worst case of the algorithm. This often makes sense because 
we can't tell before hand what type of input we'll have. Occasionally though we'll want to talk about the best case and worst 
case Big O if there's a big difference. We've already seen some examples were there's a big change.

What is the best case Big O for Bubble Sort? What's the worst case Big O for bubble sort?
<details>
- Best case: ``n``
- Worst case: ``n^2``
</details>


A practical example comes from not too long ago. In 2000, one of the most popular sorts was quick sort. While quick sort has 
average case Big O of ``n ln n`` it has a worse case Big O of ``n^2`` when the array is already sorted. Some common sorting 
classes would use quick sort to initially take data in and then once the data was sorted use bubble sort to keep the array 
sorted.

### Brute Force String Matching

![](http://i.giphy.com/12m69NIxA9Bxm0.gif)

Typically a brute force algorithm can be characterized as **checking every possibility**. It leans heavily on the
computer to find a solution, rather than being intelligent about how to conserve resources.


***
`In computer science, brute-force search or exhaustive search, also known as generate and test, is a very general problem-solving technique that consists of systematically enumerating all possible candidates for the solution and checking whether each candidate satisfies the problem's statement.`

`- wikipedia`
***

For example, you may have heard of a **brute force** attack used to crack someone's password. This
would mean trying every possible combination until you get one right.

#### Brain Storm

Discuss with your table for a few minutes what a brute force solution to string matching would look like.
Then in pairs, take 5 minutes to write some pseudo code.

<details>
	<summary>Pseudo Code for String Matching Brute Force</summary>
	- Start at the beginning of the test string
	- Check until you find the start of the test string
	- Check the next set of characters match the test string
		- if yes capture starting index
		- if no start looking for the first string
</details>

What do you think the Big O value of the brute force search is?
<details>
	We review each character so that is a loop of size *n* and we potentially do *m* operations so the overall Big O value is ``nm``.
</details>

### More advanced string matching 

If the brute force option is Big O of ``nm`` can we do better? Not really, but our average case for the brute force is 
basically the same as the worse case. We always check every character.  What can we do to try to make the average case better?

A genuis, 

![](https://github.com/den-wdi-1/string-matching/blob/master/knuth.jpg)

came up with another way to check for the matching pattern. The basic idea is to only check a portion of the document. In 
order to do this we have to store some additional data about the pattern. This idea evolved over the years between solutions
that were more complex but efficient and simpler solutions that were slightly less efficient but easier to implement. 
Eventually a good balance was balance was found by Nigel Horspool. 

Here's Horspool's algorithm
- Build a hash for each letter in the alphabet. The value is either 
	- the size of the pattern string if the letter is not in the pattern
	- the number of places to end of the pattern if the letter is in the pattern
	- This hash is called the shift table.
- Move the length of the pattern to and look up the value of the letter in the shift table.
- Until the end of the document move the number of spaces in the shift table unless the value is 0.
- If the value in the shift table is 0
	- Begin checking the previous characters in the document to see if they follow the pattern.
	- If the pattern is matched, store the index of the match
	- If not, move the size of the pattern away from the first non-matching string.

Lets figure out what the shift tables look like for some words. Assume your alphabet is just the lower case letters. You have 
to figure out what the shift values for letters that aren't in your pattern but you don't have to list them explicitly.

``background``
<details>
```ruby
	shift = {
		'd' => 0,
		'n' => 1,
		'u' => 2,
		'o' => 3,
		'r' => 4, 
		'g' => 5,
		'k' => 6,
		'c' => 7,
		'a' => 8,
		'b' => 9
	}
```
everything else would be shift of 10.
</details>

``happy``
<details>
```ruby
	shift = {
		'y' => 0
		'p' => 1,
		'a' => 3,
		'h' => 4,
	}
```
everything else would be shift of 5.
</details>

``abracadabra`` and ``mississippi``
<details>
```ruby
	abra_shift = {
		'a' => 0,
		'r' => 1
		'b' => 2,
		'd' => 4,
		'c' => 6,
	}
```
everything else would be shift of 10.


```ruby 
	miss_shift = {
		'i' => 0,
		'p' => 1,
		's' => 4,
		'm' => 10
	}
```
everything else would be shift of 11.
</details>

Let's go through a full example of the algorithm. Let's look for Florida in a state list.
```ruby
	florida_shift = {
		'a' => 0,
		'd' => 1,
		'i' => 2,
		'r' => 3,
		'o' => 4,
		'l' => 5,
		'f' => 6,
	}
```

What's an example of the worst case string for the Harspool algorithm? What does this mean for the Big(O) value of the algorithm?
<details>
	A string where the pattern almost repeats except for the first letter.

	The Big O of Harspool is `nm`
</details>

The worse case option very rarely happens though. A typical string won't match the majority of the target string. We'll typically be able to jump across multiple items. The average case of the Harspool has a Big O value of ``n + m`` 

### Practical Interview Thoughts
In general, there's no free lunch in algorithm design. When you need to decrease the number of operations, we usually need to 
increase the amount of data stored and the complexity of the code written.

Also in super technical interviews, think Google, Apple, Facebook, there are just algorithms that you need to memorize. 
These algorithms will form the basis for the interview and you're highly unlikely to be able to generate them in time to pass
the interview,

### Closing Thoughts
- Big O notation looks at the efficiency of an algorithm in its worst case scenario
- Brute force is a way to solve a problem algorithmically with no regard for efficiency
- Optimizing an algorithm always means giving up something 

## Additional Resources
- [Rob Bell, A beginner's guide to Big O notation](https://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/)
- [KMP (another powerful optimization) explained](https://www.youtube.com/watch?v=2ogqPWJSftE)
