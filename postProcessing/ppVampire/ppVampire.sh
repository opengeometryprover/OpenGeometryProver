#!/bin/sh

if grep -q 'Termination reason: Refutation' "$1"
then
    echo Proved > "$2".result
else
    echo Unkown > "$2".result
fi

exit 0
