# Creating Test Drivers

For the instructors using this application, this document will describe how to create test drivers, and the capabilities of test drivers.

## What can a test driver be?

This applications expects each test driver to be a BASH script. This gives you as an instructor, the freedom to test student submissions however you'd like. You may have your test driver run any command available on an Ubuntu Trusty 14.04 install.

## How are submissions graded?

Each submission's grade is calculated by summing up the individual grades received per test driver. A test driver's grade is calculated one of two ways:

The first of which looks at the exit status of the test driver. If the status is one of success, full points are awarded. If the status is anything other than success, no points are awarded.

The second option is for the test driver to generate a feedback file. The file should be named in accordance with the first argument supplied to the test driver. The file should contain valid YAML, looking something like the following:

```yaml
---
pass: 10
fail: 3
comments: 'This field is optional'
```

A grade from the feedback file will be calculated using the following expression: `pass / (pass + fail)`.
