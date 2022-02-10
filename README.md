# wordlR

Inspired from the viral online game [Wordle](https://www.powerlanguage.co.uk/wordle/)

The program chooses a random 5-letter word from a list of 2530 words (from [ESL forums](https://eslforums.com/5-letter-words/))

You have 6 chances to guess the word.

Like the original game, the program gives you hints regarding your guess.
1. Letters which are in their correct places, will be displayed with trailing plus signs (`+x+`)
2. Letters which are in the word but are in wrong positions, will be displayed with trailing underscores (`_x_`)
3. Letter which are not in the word, will be remain unchanged (` x `)

Even if the same letter is shown at multiple places with plus signs (`+x+ +x+`), the letter may be correct only in one position.

The program uses the package ['dictionaRy'](https://cran.r-project.org/web/packages/dictionaRy/index.html) to warn users against entered words that are incorrect. If an incorrect word is typed, a warning will be shown and the user will be asked to enter a correct word.

### Instructions

To play the game, download/clone the repository, unzip it, and source the R script file.

**For Windows:**

Open R Gui or RStudio, set the unzipped folder as your working directory, and run the command `source("wordlR.R")` in the console

In case you have added R to your system path, you can also open a command prompt/terminal, navigate to the unzipped folder, open a R prompt by typing `R` in the terminal and pressing enter, and run `source("wordlR.R")`

**For MacOS/Linux:** 

Open a terminal, navigate to the unzipped folder, open a R prompt by typing `R` in the terminal and pressing enter and run `source("wordlR.R")`

### Screenshot of the game

![Screenshot of wordlR]()
