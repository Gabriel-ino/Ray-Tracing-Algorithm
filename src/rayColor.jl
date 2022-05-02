using Images
include("./Vector.jl")
include("Sphere.jl")
include("Scene.jl")

function backgroundColor(dir)
    t = (dir[2] + 1.0)/2
    (1-t)RGB(1.0,1.0,1.0) + t*RGB(0.5, 0.7, 1.0)
end

function rayColor(ray::Ray, scenelist::SceneList)
    record = HitRecord()
    if hit!(scenelist, ray, 0.0, Inf, record)
        # Intersection
        ncolor = 0.5 * (record.normal .+ 1.0)
        return RGB(ncolor...)
    end
    backgroundColor(ray.direction)
end




