local radio=gui.baseClass:new()
radio.children={}

function radio:insert(button)
	table.insert(self.children, button)
end

function radio:draw()
	for i=1, #self.children do
		self.children[i]:draw()
	end
end

function radio:update()
	for i=1, #self.children do
		if self.children[i]:update() then
			for v=1,#self.children do
				if v~=i then
					self.children[v].toggle=false
				end
			end
		end
	end
end
return radio