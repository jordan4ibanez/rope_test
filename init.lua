--this mod allows rope entity in minetest


minetest.register_entity("fishing:line", {
    physical = true,
    collide_with_objects = false,
    collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
    visual = "mesh",
    mesh   = "fishing_line.x",
    visual_size = {x=-9, y=9},
    textures={"fishing_line.png","fishing_line.png","fishing_line.png","fishing_line.png","fishing_line.png","fishing_line.png"},
    makes_footstep_sound = false,
    yaw = 0,
    owner = "singleplayer",
    on_activate = function(self,dtime)
		self.object:set_animation({x=90,y=90}, 0, 0, false)
		self.object:setacceleration({x=0,y=-10,z=0})
		self.object:setvelocity({x=math.random(-3,3),y=math.random(-3,3),z=math.random(-3,3)})
    end,
    
    on_step = function(self,dtime)
		local pos1 = self.object:getpos()
		local pos2 = minetest.get_player_by_name(self.owner):getpos()
		pos2.y = pos2.y + 1.5
		local vec = {}
		vec.y = pos2.y - pos1.y
		vec.x = pos2.x - pos1.x
		vec.z = pos2.z - pos1.z
		
		self.yaw = math.atan(vec.z/vec.x)+math.pi/2
		
		
		if pos1.x > pos2.x then
			self.yaw = self.yaw+math.pi
		end
		self.object:setyaw(self.yaw)
		
		
		--size
		local distance = vector.distance(pos1, pos2) * -2
		self.object:set_properties({visual_size={x=distance,y=distance}})
		
		
		
		--roll
		local pitch = math.atan2(math.sqrt(vec.z * vec.z + vec.x * vec.x), vec.y)
		
		
		pitch = (pitch/math.pi)*180
		
		
		print(pitch)
		
		self.object:set_animation({x=pitch,y=pitch}, 0, 0, false)
		
			
    end,
})
