# Some common chars used for file/directory names
# ------------------------------------------------
# 0-9 ascii codes -> 48 to 57
# A-Z ascii codes -> 65 to 90
# a-z ascii codes -> 97 to 122
# ( ascii code -> 40
# ) ascii code -> 41
# - ascii code -> 45
# . ascii code -> 46
# [ ascii code -> 91
# ] ascii code -> 93
# _ ascii code -> 95

# Print out 0-9 ascii chars
#48..57 | % {“[ASCII Character Code #{0}] = {1}” –f $_, [char]$_}

# Print out A-Z ascii chars
#65..90 | % {“[ASCII Character Code #{0}] = {1}” –f $_, [char]$_}

# Print out a-z ascii chars
#97..122 | % {“[ASCII Character Code #{0}] = {1}” –f $_, [char]$_}


# Create a directory for each letter in A-Z
# Note that md is the alias for mkdir
65..90 | % {md ("{0}" -f [char]$_)}
