using Images
include("./Vector.jl")
include("Sphere.jl")
include("Scene.jl")

function backgroundColor(dir)
    t = (dir[2] + 1.0)/2
    (1-t)RGB(0.7,0.8,0.9) + t*RGB(0.05, 0.05, 0.2)
end

function rayColor(ray::Ray, scenelist::SceneList)
    record = HitRecord()
    orgn = ray.origin
    dir = ray.direction
    while hit!(scenelist, Ray(orgn, dir), 0.0001, Inf, record)
        dir =unitvector(reflect(dir, record.normal))
        orgn = record.P
        # Intersection
    end
    backgroundColor(dir)
end




