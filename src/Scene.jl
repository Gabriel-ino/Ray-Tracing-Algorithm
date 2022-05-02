include("Vector.jl")
import Base.push!

abstract type SceneObject 

end

mutable struct HitRecord{T <: AbstractFloat}
    P::Vec3{T}
    t::T
    normal::Vec3{T}

    function HitRecord{T}(p::Vec3{T}, t::T, normal::Vec3{T}) where T
        new(p, t, normal)
    end


end

HitRecord() = HitRecord{Float64}(Vec3(0.0, 0.0, 0.0), 0.0, Vec3(0.0, 0.0, 0.0))

struct SceneList <: SceneObject
    objects::Vector{SceneObject}
    
    function SceneList(obj::Vector{SceneObject})
        new(obj)
    end

end

SceneList() = SceneList(Vector{SceneObject}())

function push!(scenelist::SceneList, object::SceneObject)
    push!(scenelist.objects, object)
end











