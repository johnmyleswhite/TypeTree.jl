using JSON

function wrap(t::Type)
	d = Dict()
	d["name"] = string(t)
	s = subtypes(t)
	if !isempty(s)
		d_inner = Dict[]
		for t_inner in s
			if t_inner != t
				push!(d_inner, wrap(t_inner))
			end
		end
		d["children"] = d_inner
	end
	return d
end

r = wrap(Any)

io = open("types.json", "w")
JSON.print(io, r)
close(io)
