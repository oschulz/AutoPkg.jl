# AutoPkg.jl

AutoPkg.jl is mainly intended to handle automatic package installation for standalone Julia scripts, Jupyter (esp. Google Colab) notebooks and the like.

(Note: Do *not* use `@autopkg` with Julia [Pluto](https://plutojl.org/) notebooks, as Pluto has a built-in package management.)

AutoPkg provides a macro `@autopg` that automatizes Julia `Pkg` operations, so that one can write, e.g.

```julia
@autopkg begin
    using SomePackage, SomeOtherPackage
    import YetAnotherPackage

    if some_condition
        using OneMorePackage: some_feature
    end
end
```

`autopkg` creates and activates a temporary project environment, adds all packages referred to in the code block (whether conditional or not) and then executes the code block.

`@autopkg` also sets the environment variable `$JULIA_PKG_PRESERVE_TIERED_INSTALLED` to `"true"`, to re-use packages already present in the Julia package depot if possible.


## Auto-loading AutoPkg.jl

`@autopkg` is also very handy for casual use on the REPL, e.g. to quickly try out some Julia packages, but having to write `using AutoPkg` first is annoying.

To auto-load AutoPkg via [BasicAutoloads](https://github.com/LilithHafner/BasicAutoloads.jl), add `BasicAutoloads` to your default Julia environment and add

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
