
--[[

  torchsmoke - CSM particle demo

  (C) 2018 Auke Kok <sofar@foo-projects.org>

   Permission to use, copy, modify, and/or distribute this software
   for any purpose with or without fee is hereby granted, provided
   that the above copyright notice and this permission notice appear
   in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR
BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES
OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
SOFTWARE.


The texture is from `isabella II` texture pack - Public-Domain.

--]]

minetest.log("action", "torchsmoke mod loaded.")

local me

local function do_torch_particles()
	if not me then
		return
	end

	-- grab player pos
	local pos = me:get_pos()

	-- find torches nearby
	for x = -12, 12 do
	for z = -12, 12 do
	for y = -6, 6 do
		local p = vector.add(pos, {x = x, y = y, z = z})
		local node = minetest.get_node_or_nil(p)
		if node and node.name:match("torch") and math.random(128) == 1 then

			p.y = p.y + 0.5
			-- do particles
			minetest.add_particle({
				pos = vector.add(p, math.random(15)/100 - 0.075),
				velocity = {x = math.random(20)/100 - 0.1, y = 0.3, z = math.random(20)/100 - 0.1},
				expirationtime = 2.3,
				size = math.random(10)/5 + 2,
				texture = "smoke_animated.png",
				glow = 14,
				animation = {
					type = "sheet_2d",
					frames_w = 8,
					frames_h = 1,
					frame_length = 0.3,
				},
			})
		end
	end
	end
	end

end

minetest.register_globalstep(do_torch_particles)

local function get_localplayer()
	if me then
		return
	end
	minetest.after(1.0, get_localplayer)
	me = core.localplayer
end

minetest.after(1.0, get_localplayer)

