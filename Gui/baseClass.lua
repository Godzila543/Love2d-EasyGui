base={}
base.pos=vector.new(0,0)
function base:new(o)
	o=o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
return base


