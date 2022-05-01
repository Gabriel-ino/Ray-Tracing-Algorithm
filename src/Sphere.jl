include("Vector.jl")


struct Sphere{T <: AbstractFloat}
    center::Vec3{T}
    radius::T

    function Sphere{T}(c::Vec3{T}, r::T) where T
        new(c, r)
    end
end

function Sphere(c::Vec3{T}, r::T) where T
    Sphere{T}(c, r)
end

function hit(s::Sphere, ray::Ray)
    # bhaskara
    a = normsquared(ray.direction)
    oc = s.center - ray.origin
    b = 2.0 * dot(ray.direction, oc)
    c = normsquared(oc) - s.radius^2
    discriminant = b^2 - 4 * a * c
    if discriminant <= 0
        return false
    end
    true

end









