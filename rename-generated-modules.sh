#!/bin/bash

perl -pi -e 's/(On)*Flow\.(Access|Entities|Execution)/OnFlow.$2/g' lib/on_flow/generated/**/*.ex test/* test/**/*
