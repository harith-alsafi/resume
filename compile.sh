#!/bin/sh
# Usage: ./compile.sh [watch]
cd "$(dirname "$0")" && typst "${1:-compile}" --font-path fonts harith-alsafi-fullstack.typ harith-alsafi-fullstack-typst.pdf
