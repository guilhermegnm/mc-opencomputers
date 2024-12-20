local fs = require("filesystem")
local proxy = ...
fs.mount(proxy, "/md")

os.execute("wget -O 'https://raw.githubusercontent.com/guilhermegnm/mc-opencomputers/refs/heads/main/script.lua' /md/sk.lua")

sk.lua