# Isaac Racine
# 3.9.21

# --------------------Snippets---------------------
# text macros that put in predefined text
# Save time on typing

#ctrl + shift + r: crates a section label
# practice label ----------------------------------------------------------

#fun function: type fun and hit tab
  #automatically generates a function
my_fun <- function(x = 5) {
  z <- 5 + runif(1)
  return(z)
}

my_fun()
  #however already created function format in text file

#making chanes to snippits
#tools -> global options -> code -> edit snippets
#must use tap key after snippet decleration
#usually start name with letter m so that we know its mine

#typed m_bar and got:
#############################################  

#use ${1:prompt} to make popup box

#try m_sec
#-------------- this is practice ---------------


#can even build snippets w r code
#try m_head, date and time done w r script
#------------------------------------------------
# Practice bro
# 09 Mar 2021
# ISR
#------------------------------------------------


#one more snippet
#function format
#---------------------------------------
# FUNCTION Hello_world
# description: this function is a practice
# inputs: x is 5, default i set
# outputs: none !
########################################
Hello_world <- function(x = 5) {
  
# function body

return("Checking ... Hello_world")

} # end of Hello_world
#-----------------------------------------

Hello_world()
