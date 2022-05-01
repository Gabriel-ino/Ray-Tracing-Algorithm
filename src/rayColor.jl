using Images
include("./Vector.jl")
include("Sphere.jl")

function backgroundColor(dir)
    t = (dir[2] + 1.0)/2
    (1-t)RGB(1.0,1.0,1.0) + t*RGB(0.5, 0.7, 1.0)
end

function rayColor(ray::Ray, sphere::Sphere)
    t = hit(sphere, ray)

    if t > 0.0
        # Intersection
        p = rayAt(ray, t)
        normal = unitvector(p - sphere.center)
        ncolor = 0.5 * (normal .+ 1.0)
        return RGB(ncolor...)
    end
    backgroundColor(ray.direction)
end




