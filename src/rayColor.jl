using Images
include("./Vector.jl")
include("Sphere.jl")

function backgroundColor(dir)
    t = (dir[2] + 1.0)/2
    (1-t)RGB(1.0,1.0,1.0) + t*RGB(0.5, 0.7, 1.0)
end

function rayColor(ray::Ray, sphere::Sphere)
    if hit(sphere, ray)
        return RGB(1.0, 0.0, 0.0)
    end
    backgroundColor(ray.direction)
end




