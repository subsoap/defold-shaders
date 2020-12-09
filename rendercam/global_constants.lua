local M = {}
M.constants = {}

function M.get()
	local constants = render.constant_buffer()
	for k,v in pairs(M.constants) do
		constants[k] = v
	end
	return constants
end

function M.set(id, value)
	M.constants[id] = value
end

function M.reset()
	M.constants = {}
end

return M