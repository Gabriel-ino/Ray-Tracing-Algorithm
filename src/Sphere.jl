include("Vector.jl")
include("Scene.jl")


struct Sphere{T <: AbstractFloat} <: SceneObject
    center::Vec3{T}
    radius::T

    function Sphere{T}(c::Vec3{T}, r::T) where T
        new(c, r)
    end
end

function Sphere(c::Vec3{T}, r::T) where T
    Sphere{T}(c, r)
end

function hit!(s::Sphere, ray::Ray, t_min, t_max, record::HitRecord) # We use ! because the variable record will be modified
    # bhaskara
    a = normsquared(ray.direction)
    oc = ray.origin - s.center
    halfb = dot(ray.direction, oc)
    c = normsquared(oc) - s.radius^2
    discriminant = halfb * halfb - a * c
    if discriminant <= 0
        return false
    end
    
    sqrtd = √discriminant
    t = (-halfb - sqrtd) / a
    if t < t_min || t > t_max
        t = (-halfb + sqrtd) / a
        if t < t_min || t > t_max
            return false
        end
    
    end
    record.t = t
    record.P = rayAt(ray, t)
    outward_normal = unitvector(record.P - s.center)
    front_face = dot(ray.direction, outward_normal) < 0
    record.normal = front_face ? outward_normal : -outward_normal
    true
      
end

function hit!(scenelist::SceneList,  ray::Ray, t_min, t_max, record::HitRecord)
    hitanything = false
    temprecord = HitRecord()
    closestsofar = t_max
    for object in scenelist.objects
        if hit!(object, ray, t_min, closestsofar, temprecord)
            hitanything = true
            closestsofar = temprecord.t

            record.P = temprecord.P
            record.t = temprecord.t
            record.normal = temprecord.normal
        end
    end

    return hitanything

end

function reflect(dir::Vec3, normal::Vec3)
    dir - 2.0 * dot(dir, normal) * normal
end








