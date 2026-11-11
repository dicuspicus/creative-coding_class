# CREATIVE CODING CLASS
## PART 1:

### Exploration of If Statements:  
I created a snow simulation with different colours based on each snowflake's scale, which creates depth. And sorry, Michael, those are just bullet points; I will drop everything I know in part 2.

### Exploration of Arrays and for Loops:  
For the second one, I made a bubble sort with rainbow visuals. Nice! (Though, remaking the loop into if-statements literally incinerated my soul)

### Exploration of Classes: 
I made classes in (almost) each one because they are that useful. For the third one, I made a simple pong game, though it has bugs and I have a fever; I barely comprehend what I was writing. But it works, even uses SUPERRRRRR keyword.

### Exploration of importing images and libraries:  
The simplest one yet; it sounded funnier in my head...

## PART 2:

### Author's note
This is my Magnus Opus of Processing 4. I enjoyed coming back to simple times of visual stuff in coding; the last time I had this much fun with pure coding was back in my User Interface classes at university, but I feel that C# was a tiny bit more advanced...

So let's start with everything I used; the first one is the basic one - variables!
Variables - a common thing found in most (MOST, not every) languages; speaking mathematically, it's your unknown, but in coding you are the one writing equations for kids, so you are setting this unknown to whatever you want. But at the same time, you are God and can make it into WHATEVER you want - pictures, sounds, numbers, colours, players, vectors, or, God forbid, multiple things with the same name across the whole code. 
In Processing 4 we have all of the Java's Primitive variable types:

| byte | short | int | long | float | float | double | boolean | char |
| :--: | :---: | :-: | :--: | :---: | :---: | :----: | :-----: | :--: |

But there are three more: **String**, **Array** and **Classes**.

And there are unique to Processing too:

| ArrayList | FloatDict | FloatList | HashMap | IntDict | IntList | JSONArray | 
| :-------: | :-------: | :-------: | :-----: | :-----: | :-----: | :-------: |
| JSONObject | Object | StringDict | XML | Table | TableRow | StringList |

Then I put variables into functions... oh, here we go with another one!
Functions are your actions, basically a neatly wrapped piece of pure action. Like you have a recipe that asks you to stir, right? And stirring could be a function that your mom called for you to do: stir, gosh darn it! And how long? That's a variable that was called with your function. That's the basics.

But let's talk about what happens inside of functions. Inside, we have all kinds of stuff happening to our poor variables! To mess with them, we use operators. Operators are the same thing as in math, but we have more of those here. We have:

### Arithmetic

| Operator | Name           | Description                              | Example  |
|----------|----------------|------------------------------------------|----------|
| `+`      | Addition       | Adds together two values                 | `x + y`  |
| `-`      | Subtraction    | Subtracts one value from another          | `x - y`  |
| `*`      | Multiplication | Multiplies two values                     | `x * y`  |
| `/`      | Division       | Divides one value by another              | `x / y`  |
| `%`      | Modulus        | Returns the division remainder            | `x % y`  |
| `++`     | Increment      | Increases the value of a variable by 1    | `x++`    |
| `--`     | Decrement      | Decreases the value of a variable by 1    | `x--`    |

### Assignment

| Operator | Example    | Same As       |
|----------|------------|---------------|
| `=`      | `x = 5`    | `x = 5`       |
| `+=`     | `x += 3`   | `x = x + 3`   |
| `-=`     | `x -= 3`   | `x = x - 3`   |
| `*=`     | `x *= 3`   | `x = x * 3`   |
| `/=`     | `x /= 3`   | `x = x / 3`   |
| `%=`     | `x %= 3`   | `x = x % 3`   |
| `&=`     | `x &= 3`   | `x = x & 3`   |
| `\|=`     | `x \|= 3`   | `x = x \| 3`   |
| `^=`     | `x ^= 3`   | `x = x ^ 3`   |
| `>>=`    | `x >>= 3`  | `x = x >> 3`  |
| `<<=`    | `x <<= 3`  | `x = x << 3`  |

### Comparison

| Operator | Name                      | Example   |
|----------|---------------------------|-----------|
| `==`     | Equal to                  | `x == y`  |
| `!=`     | Not equal                 | `x != y`  |
| `>`      | Greater than              | `x > y`   |
| `<`      | Less than                 | `x < y`   |
| `>=`     | Greater than or equal to  | `x >= y`  |
| `<=`     | Less than or equal to     | `x <= y`  |

### Logical

| Operator | Name       | Description                                      | Example             |
|----------|------------|--------------------------------------------------|---------------------|
| `&&`     | Logical and | Returns true if both statements are true         | `x < 5 && x < 10`   |
| `\|\|`   | Logical or  | Returns true if one of the statements is true    | `x < 5 \|\| x < 4`  |
| `!`     | Logical not | Reverses the result; returns false if the result is true | `!(x < 5 && x < 10)` |

Okay, that was a lot and totally not stolen from w3schools.com. Next one is... conditions and if statements!
If statements are the basics of branching in coding: if that, you do that, else you do that, you know? Like if you are sick and tired, then you rest; else you work. (╥﹏╥)
I prefer using switch statements as a faster version, but no one beats the simplicity of an if statement, except maybe for this weird thing ()?():(). An if statement checks the condition you give (is_sick), and if it's true (I am), it will go to the true branch (rest). (ಥ﹏ಥ)
Anyway, switch statements are a type of branching that allows you to have more than two branches. It's useful basically anywhere with condition being not only true or false. An example would be

```javascript
switch (tea) {
    case black:
        (Add 2 sugars)
        drink;
    case green:
        (Add 1 sugar)
        drink;
    case berry:
        (Add no sugar)
        drink;
    case default:
        (love)
        drink;
}
```

Next one is my favourite - LOOOOOOPS!!!!
We have a few types, but generally those are repeating actions, like an average week of an office worker- the same thing repeating again and again. Loops will repeat themselves until the condition is met, but when and what the condition is differs from loop to loop.
The most popular and objectively the best one is the for-loop. 

```javascript
for(day = 1; day < 30; day++){
    wake up;
    go to work;
    go home;
    sleep;
}
```

Then we have twins while and do while. Those are similar in their basics, but the condition is checked at different times.

```javascript
while(employed){
    go to work;
    go home;
    sleep;
    wake up;
}

do{
    do something dumb;
} while (asked)
```

In the first one, we check if we are employed, and then we go to work, but in the second one, we do something dumb, and then we ask. But there's more! What if we want to stop ourselves from doing an actually dumb thing? Then we could use a **break**!

```javascript
do{
    start something;
    if (dumb) {
        break from this loop!!!!;
    }
} while (asked)
```

But what if we don't want to do stuff, only the dumb one? Then we could use **continue**!

```javascript
do{
    start something;
    if (dumb) {
        continue but carefully;
    }
} while (asked)
```

**Break** totally stops the loop, so it won't continue, while **continue** allows the loop to go; only the rest of the current loop will be skipped.

Okay, the last one I will tell you about (because I am getting tired and sleepy) is the arrays, which are... well, arrays, collections, sets, compendiums! Arrays let you store multiple variables under the same name, like, why name each apple in the basket? Oh yeah, I will use Jerry, Ben and Josh for the apple pie - nonsense! That's why we use arrays; in this case, we would use Jerrys_Bens_Joshs[10] instead. That means that we have 10 apples, and the first one has an index of... 0. Yeah, coders, am I right?

Anyway, I won't tell you about classes; I won't tell you about how they are a structure with methods and attributes that can allow you to have an even more neatly structured set of functions (methods) and variables (attributes). And definitely won't tell you that it has a cool thing called a constructor that works as a blueprint for the class. That's it then, bye!
