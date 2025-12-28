# This file is a part of AutoPkg.jl, licensed under the MIT License (MIT).

import Test

Test.@testset "Package AutoPkg" begin
    include("test_aqua.jl")
    include("test_autopkg_macro.jl")
    include("test_docs.jl")
end # testset
