# Creating Test Drivers

For the instructors using this application, this document will describe how to create test drivers, and the capabilities of such.

## What can a test driver be?

A test driver must be an executable file, and a [#!](https://en.wikipedia.org/wiki/Shebang_(Unix)) should be used to specify how the driver should be interpreted. NO FILE EXTENSIONS SHOULD BE USED TO NAME THE DRIVER.

### Packaing the Driver in an Archive

If you need to included data files, or any files in addition to the driver itself, you may package them all within a ZIP archive. It is important to note that the driver contained within the archive, and the archive itself, must be named the exact same (disregarding the file extension). The driver must also be put in the root of the archive so that the grader can easily find it.

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
