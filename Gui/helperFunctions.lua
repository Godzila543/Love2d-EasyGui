function drawinrect(img, x, y, w, h, r)
    local wid, hei = img:getDimensions()
    
    return love.graphics.draw(img, x, y, r or 0, w / wid, h / hei)
end

function math.lerp(v0,v1,t)
	-- body
	return (1 - t) * v0 + t * v1
end