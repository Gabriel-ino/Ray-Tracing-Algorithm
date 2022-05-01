using Images
include("./Vector.jl")

function rayColor(ray::Ray)
    t = (ray.direction[2] + 1.0)/2
    (1-t)RGB(1.0,1.0,1.0) + t*RGB(0.5, 0.7, 1.0)

end


