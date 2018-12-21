# Contributing Guidelines

## General

* Contributions of all kinds (issues, ideas, proposals), not just code, are highly appreciated.
* Pull requests are welcome with the understanding that major changes will be carefully evaluated
and discussed, and may not always be accepted. Starting with a discussion is always best!
* All contributions including documentation, filenames and discussions should be written in English language.

## Issues

Our [issue tracker](https://github.com/datadotworld/data.world-r/issues) can be used to report
issues and propose changes to the current or next version of the data.world Excel add-in.

## Contribute Code

### Review Relevant Docs

* [data.world API](https://apidocs.data.world)
* [R pkg development best practices](http://r-pkgs.had.co.nz/)

### Set up machine

Install:

* R
* R Studio
* devtools

### Fork the Project

Fork the [project on Github](https://github.com/datadotworld/data.world-r) and check out your copy.

```
git clone https://github.com/[YOUR_GITHUB_NAME]/data.world-r.git
cd data.world-r
git remote add upstream https://github.com/datadotworld/data.world-r.git
```

### Install and Test

Ensure that you can build the project and run tests.

Install dependencies:
```r
devtools::install()
```

Run `testthat` tests:
```r
devtools::test()
```

### Create a Feature Branch

Make sure your fork is up-to-date and create a feature branch for your feature or bug fix.

```bash
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

### Write Tests

Try to write a test that reproduces the problem you're trying to fix or describes a feature that
you want to build. Add tests to [tests](tests).

We definitely appreciate pull requests that highlight or reproduce a problem, even without a fix.

### Write Code

Implement your feature or bug fix.

Make sure that `devtools::test()` completes without errors.

### Write Documentation

Document any external behavior in the [README](README.md).
Make sure that functions are documented in code and that vignettes are add/updated as needed.

### Commit Changes

Make sure git knows your name and email address:

```bash
git config --global user.name "Your Name"
git config --global user.email "contributor@example.com"
```

Writing good commit logs is important. A commit log should describe what changed and why.

```bash
git add ...
git commit
```

### Push

```bash
git push origin my-feature-branch
```

### Make a Pull Request

Go to <https://github.com/[YOUR_GITHUB_NAME]/data.world-r> and select your feature branch.
Click the 'Pull Request' button and fill out the form. Pull requests are usually reviewed within
a few days.

# Release (for maintainers)

Checklist:

- Version number is correct in DESCRIPTION
- NEWS.md and cran-comments.md are updated
- Docs and vignettes are updated
- Build passes checks (`devtools::check()`)
- Build passes Windows tests (https://win-builder.r-project.org/upload.aspx)

Release process:

R packages are uploaded manually via https://cran.r-project.org/submit.html

# Thank you!

Thank you in advance, for contributing to this project!
