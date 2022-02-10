# List of 2530 five-letter words from https://eslforums.com/5-letter-words/

########################## Show the rules ###################################

writeLines("\nWelcome to wordlR - a wordle-like game in R\n
Rules:\n
The program will select a 5-letter word\n
You have 6 chances to guess the word\n
At each try, enter a word at the prompt\n
If correct, 'Congratulations! you have guessed right!' will be displayed\n
If not, hints will be displayed\n
Hint 1: correct letters at correct places will have trailing underscores (_x_)\n
Hint 2: correct letters at incorrect places will have trailing plus signs (+x+)\n
Hint 3: letters not in the word will remain unchanged (x)\n
Even if same letter is shown at multiple places with plus signs (+x+ +x+),
the letter may be correct only in one position.")

############################  Preparation  ###################################

# Installing necessary packages
pck_ins <- installed.packages()
if (!("pacman" %in% pck_ins)) {
    install.packages("pacman", dependencies = T)
}
library(pacman)
p_load(dictionaRy, knitr)

# Reading text file
d <- scan("words.txt", character(), quote = "", quiet = T)

# Choosing a random word
word <- sample(d, 1)

############################  User input  ###################################

# first user input
us_in <- readline("\nEnter a 5 letter word, in small letters: ")

# Function for checking entered word in dictionary
word_chk <- function(x) {
    word_entered <- x
    dic_chk <- define(word_entered)
    # If word not in dictionary, ask user to enter a correct word
    if (nrow(dic_chk) == 0) {
        word_entered <- readline("Not in dictionary. Enter a correct word, in small letters: ")
        word_chk(word_entered)
    # If word in dictionary, use the entered word
    } else {
       return(word_entered)
    }
}

# Checking if entered word is in dictionary
chkd_word <- suppressMessages(word_chk(us_in))

######################### Wordle logic #######################################

wordle_func <- function(y) {
    vec <- character()
    # Split the words into single characters
    to_check <- strsplit(y, split = "")
    target <- strsplit(word, split = "")
    for (i in 1:5) {
        if (to_check[[1]][i] == target[[1]][i]) {
            # If letter is correct and is in correct position
            vec[i] <- paste0("_", to_check[[1]][i], "_")
        } else if (to_check[[1]][i] %in% target[[1]]) {
            # If letter is correct but is in wrong position
            vec[i] <- paste0("+", to_check[[1]][i], "+")
        } else {
            # If letter is not in word
            vec[i] <- to_check[[1]][i]
        }
    }
    return(vec)
}

######################### User interaction ##################################

# Creating an empty matrix for output
mat <- matrix(rep("-", 30), ncol = 5, nrow = 6)
out_df <- data.frame(mat)
colnames(out_df) <- c(1, 2, 3, 4, 5)

# Output for first try
if (chkd_word == word) {
    writeLines("\nCongratulations! you have guessed right!")
} else {
    row_one <- wordle_func(chkd_word)
    out_df[1, ] <- row_one
    print(kable(out_df, format = "rst", row.names = T))
    us_nxt <- readline("\n\nEnter the next guess: ")
    chkd_word_nxt <- suppressMessages(word_chk(us_nxt))
}

# Output for rest of the tries
for (i in 2:6) {
    if (chkd_word_nxt == word) {
        out_df[i, ] <- paste0("_", strsplit(word, split = "")[[1]], "_")
        print(kable(out_df, format = "rst", row.names = T))
        writeLines("\nCongratulations! you have guessed right!")
        break
    } else {
        new_row <- wordle_func(chkd_word_nxt)
        out_df[i, ] <- new_row
        print(kable(out_df, format = "rst", row.names = T))
        # Output if the user has come to the 6th try
        if (i == 6) {
            writeLines("\nGAME OVER!")
            writeLines(paste0("\nThe correct word was: ", word))
        } else {
            us_nxt <- readline("\n\nEnter the next guess: ")
            chkd_word_nxt <- suppressMessages(word_chk(us_nxt))
        }
    }
}
