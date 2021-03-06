module raytracing

#import Pkg; Pkg.add("Images")

using Images
include("./Vector.jl")
include("rayColor.jl")
include("Scene.jl")

# IMAGE
const ASPECTRATIO = 16/9
const IMWIDTH = 800
const IMHEIGHT = trunc(Int64, IMWIDTH / ASPECTRATIO)
const BLUE = 0.25 # Blue is a constant value on the algorithm

# CAMERA
const VIEWPORTHEIGHT = 2.0
const VIEWPORTWIDTH = VIEWPORTHEIGHT * ASPECTRATIO
const HORIZONTAL = Vec3(VIEWPORTWIDTH, 0.0, 0.0)
const VERTICAL = Vec3(0.0, VIEWPORTHEIGHT, 0.0)
const FOCALLENGTH = 1.0
const ORIGIN = Vec3(0.0, 0.0, 0.0)
const LOWERLEFTCORNER = ORIGIN - HORIZONTAL/2 - VERTICAL/2 - Vec3(0.0, 0.0, FOCALLENGTH)

image = RGB.(zeros(IMHEIGHT, IMWIDTH))

println("Image Size: $IMWIDTH x $IMHEIGHT")

s1 = Sphere(Vec3(0.0, 0.0, -1.5), 0.5)
s2 = Sphere(Vec3(-1.0, 0.0, -2.0), 0.5)
s3 = Sphere(Vec3(0.5, 1.5, -1.5), 0.5)
s4 = Sphere(Vec3(1.5, 0.2, -1.0), 0.5)
const BIGRADIUS = 1000.0
floor = Sphere(Vec3(0.0, -BIGRADIUS - 0.5, -1.0), BIGRADIUS)

world = SceneList()
push!(world, s1)
push!(world, s2)
push!(world, s3)
push!(world, s4)
push!(world, floor)
for j = 1:IMHEIGHT
    for i = 1:IMWIDTH
        u = (i - 1)/(IMWIDTH-1)
        v = 1.0 - (j-1)/(IMHEIGHT - 1)
        direction = LOWERLEFTCORNER + u * HORIZONTAL + v * VERTICAL - ORIGIN
        ray = Ray(ORIGIN, direction)

        image[j, i] = rayColor(ray, world)
    end
end # Looping all positions in image's matrix

a = Vec3(6.0,4.0,3.0)
b = Vec3(0.0, 1.0, 10.0)

ray = Ray(a, b)

println("Vector A: ", a)
println("Dot A B ", dot(a, b))

save("rendered/image8.png", image)

end