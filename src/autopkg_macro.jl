# This file is a part of AutoPkg.jl, licensed under the MIT License (MIT).

const _autopkg_project = Ref("")
const _autopkg_activated = Ref(false)
const _autopkg_lock = ReentrantLock()
const _autopkg_added = Set{String}()


function _activate_autopkg()
    @lock _autopkg_lock begin
        if !_autopkg_activated[]
            get!(ENV, "JULIA_PKG_PRESERVE_TIERED_INSTALLED", "true")

            if isempty(_autopkg_project[])
                Pkg.activate(; temp = true)
            else
                Pkg.activate(_autopkg_project[])
                Pkg.instantiate()
            end
        end
        _autopkg_project[] = Pkg.project().path
        # @debug "AutoPkg activated Julia project \"$(_autopkg_project[])\""
        _autopkg_activated[] = true
    end
end


function _add_packages(packages::AbstractVector{<:AbstractString})
    @lock _autopkg_lock begin
        _activate_autopkg()
        if !isempty(packages)
            new_pkgs = setdiff(packages, _autopkg_added)
            if !isempty(new_pkgs)
                Pkg.add(new_pkgs; preserve = Pkg.PRESERVE_TIERED_INSTALLED)
                union!(_autopkg_added, new_pkgs)
            end
        end
    end
end


"""
    @autopkg expr

Looks for `using` and `import` statements in `expr`, and adds the required
packages to a temporary Julia project environment before evaluating `expr`.

Always activates a temporary project environment on first use, no matter
if `expr` contains any `using` or `import` statements or not.

`@autopkg` sets the environment variable
`\$JULIA_PKG_PRESERVE_TIERED_INSTALLED` to `"true"`, to re-use packages
already present in the Julia package depot if possible.

Example:

```
@autopkg begin
    using SomePackage, SomeOtherPackage
    import YetAnotherPackage

    if some_condition
        using OneMorePackage: some_feature
    end
end
```
"""
macro autopkg(expr)
    function extract_pkgnames(ex)
        if !(ex isa Expr)
            Symbol[]
        elseif ex.head in (:using, :import)
            [(p.head == :. ? only(p.args) : only(p.args[1].args))::Symbol for p in ex.args]
        elseif ex.head in (:block, :let)
            vcat(extract_pkgnames.(ex.args)...)
        elseif ex.head in (:if, :elseif, :for, :while)
            vcat(extract_pkgnames.(ex.args[2:end])...)
        else
            Symbol[]
        end
    end
    pkgnames = extract_pkgnames(expr)
    return :(AutoPkg._add_packages($(String.(unique(pkgnames)))); $expr)
end
export @autopkg
