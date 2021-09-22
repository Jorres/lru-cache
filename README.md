## Preface

To person who will check this:  

I understand Lua is a programming language you will MOST CERTAINLY not 
have locally and will not bother installing. Therefore, I included 
`lua` binary and `luainit` testing library for convenience, so this work
could be checked with zero-config after cloning the repo. 

Why Lua???

I'm starting to learn Lua right now to use it in an open-source community 
for creating Neovim plugins. This homework was a good opportunity to start 
practicing it. 


## Repo structure

This repository contains:
1. implementation of a double-linked list. I know I should not have implemented  
this from scratch, but Lua is a new 
2. LRU data structure implementation, with O(1) put and check operations.  


Launch tests for the list data structure:
`./lua list_spec.lua`
Launch tests for the LRU:
`./lua lru_spec.lua`
