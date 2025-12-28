# This file is a part of AutoPkg.jl, licensed under the MIT License (MIT).

using Test
using AutoPkg
import Documenter

Documenter.DocMeta.setdocmeta!(
    AutoPkg,
    :DocTestSetup,
    :(using AutoPkg);
    recursive = true
)
Documenter.doctest(AutoPkg)
