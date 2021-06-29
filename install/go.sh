#!/bin/sh

separator
gei 1.14.0

small_separator
gei 1.15.0

small_separator
gei 1.15.3

echo 'Setting go 1.15.3 as the global version...'
goenv global 1.15.3

gg github.com/golang/dep true
gg github.com/gorilla/mux true
gg github.com/motemen/gore
gg golang.org/x/sys
gg golang.org/x/mod
gg golang.org/x/text
gg golang.org/x/tools
gg golang.org/x/xerrors
gg gopkg.in/stack.v0 true

