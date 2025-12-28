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

`autopkg` creates and activates a temporary project environment (except in
Google Colab notebooks, which run isolated anyway), adds all packages referred
to in the code block (whether conditional or not) and then executes the code
block.


## Documentation

* [Documentation for stable version](https://oschulz.github.io/AutoPkg.jl/stable)
* [Documentation for development version](https://oschulz.github.io/AutoPkg.jl/dev)


## Auto-loading AutoPkg.jl

`@autopkg` is also very handy for casual use on the REPL, e.g. to quickly try
out some Julia packages, but having to write `using AutoPkg` first is
annoying.

To auto-load AutoPkg via
[BasicAutoloads](https://github.com/LilithHafner/BasicAutoloads.jl),
add `BasicAutoloads` to your default Julia environment and add

```julia
if isinteractive()
	try
		import BasicAutoloads
		BasicAutoloads.register_autoloads([
			["@autopkg"] => :(using AutoPkg),
		])
	catch e
		@warn "Error while setting up BasicAutoloads" exception=(e, catch_backtrace())
	end
end
```

to your `~/.julia/config/startup.jl` file.

Now `@autopkg` will automatically be available in interactive Julia sessions.


## Similar packages

[AddPackage.@add](https://github.com/mossr/AddPackage.jl) is similar to
`@autopkg`, but more limited in the syntax it supports and does not offer
temporary project environments.
