local split={}
split.split=false
split.smooth=0
split.pos=vector.new(0,0)

function split:new(o)
	o=o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function split:insert(button)
	if self.children then else self.children={} end
	self.children[#self.children+1]=button
	self.chosen=#self.children
end

function split:draw()
	if self.smooth~=0 then 
		for i=1, #self.children do
			if i~=self.chosen then
				self.children[i]:draw(math.lerp(self.pos.x, self.children[i].pos.x,self.smooth),math.lerp(self.pos.y, self.children[i].pos.y,self.smooth))
			end
		end
		self.children[self.chosen]:draw(math.lerp(self.pos.x, self.children[self.chosen].pos.x,self.smooth),math.lerp(self.pos.y, self.children[self.chosen].pos.y,self.smooth))
	else
		self.children[self.chosen]:draw(self.pos.x, self.pos.y)
	end
end

function split:update(dt)
	if self.split then 
		for i=1, #self.children do
			if self.children[i]:update() then
				self.split=false
				self.chosen=i
				for v=1,#self.children do
					if v~=i then
						self.children[v].toggle=false
					end
				end
			end
		end
	else
		if self.children[self.chosen]:update(self.pos.x, self.pos.y) then
			self.split=true
		end
	end
	if self.split then
		self.smooth=self.smooth-((self.smooth-1)*5*dt)
	else
		self.smooth=self.smooth-((self.smooth-0)*5*dt)
		if self.smooth<0.001 then
			self.smooth=0
		end
	end
end
return split