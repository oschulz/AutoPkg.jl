# This file is a part of AutoPkg.jl, licensed under the MIT License (MIT).

import Test
import Aqua
import AutoPkg

Test.@testset "Package ambiguities" begin
    Test.@test isempty(Test.detect_ambiguities(AutoPkg))
end # testset

Test.@testset "Aqua tests" begin
    Aqua.test_all(
        AutoPkg,
        ambiguities = true
    )
end # testset
