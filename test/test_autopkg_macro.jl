# This file is a part of AutoPkg.jl, licensed under the MIT License (MIT).

# @autopkg switches environment, so `using AutoPkg` won't work if run twice:
isdefined(Main, Symbol("@autopkg")) || using AutoPkg

using Test


@testset "autopkg_macro" begin
    @autopkg begin
        using JSON, StructArrays
        begin
            if 1 == 2
                import Tables
            elseif 1 == 1
                import ChangesOfVariables as CoV, ArraysOfArrays as AoA
            else
                let
                    using Adapt: adapt, adapt_structure
                end
            end

            let
                using Adapt: Adapt, adapt_structure
            end
        end
    end

    @test JSON isa Module
    @test StructArray isa Type
    @test isdefined(Main, :CoV)
    @test isdefined(Main, :AoA)
    @test !isdefined(Main, :adapt)
    @test Adapt isa Module
    @test adapt_structure isa Function

    @autopkg using LinearAlgebra, QuadGK
    @test cholesky isa Function
    @test quadgk isa Function
end
