# AutoPkg.jl

[![Documentation for stable version](https://img.shields.io/badge/docs-stable-blue.svg)](https://oschulz.github.io/AutoPkg.jl/stable)
[![Documentation for development version](https://img.shields.io/badge/docs-dev-blue.svg)](https://oschulz.github.io/AutoPkg.jl/dev)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](LICENSE.md)
[![Build Status](https://github.com/oschulz/AutoPkg.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/oschulz/AutoPkg.jl/actions/workflows/CI.yml)
[![Codecov](https://codecov.io/gh/oschulz/AutoPkg.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/oschulz/AutoPkg.jl)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

AutoPkg.jl is mainly intended to handle automatic package installation for
standalone Julia scripts, Jupyter (esp. Google Colab) notebooks and the like.

(Note: Do *not* use `@autopkg` with Julia [Pluto](https://plutojl.org/)
notebooks, as Pluto has a built-in package management.)

AutoPkg provides a macro `@autopg` that automatizes Julia `Pkg` operations, so
that one can write, e.g.

```julia
@autopkg begin
    using SomePackage, SomeOtherPackage
    import YetAnotherPackage

    if some_condition
        using OneMorePackage: some_feature
    end
end
```

`autopkg` creates and activates a temporary project environment, adds all
packages referred to in the code block (whether conditional or not) and then
executes the code block.

Do *not* use `@autopkg` with Julia [Pluto](https://plutojl.org/) notebooks, as
Pluto uses a built-in package management.

## Documentation

* [Documentation for stable version](https://oschulz.github.io/AutoPkg.jl/stable)
* [Documentation for development version](https://oschulz.github.io/AutoPkg.jl/dev)


## Similar packages

[AddPackage.@add](https://github.com/mossr/AddPackage.jl) is similar to
`@autopkg`, but more limited in the syntax it supports and does not offer
temporary project environments.
