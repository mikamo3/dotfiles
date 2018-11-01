#!/bin/bash
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -la'
PS1='[\u@\h \W]\$ '
