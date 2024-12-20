component = require("component")
ae2 = component.proxy("3758bac3-4b04-4778-9fc4-05b563642f4f")

cpus = ae2.getCpus()

busy = 0

for i in ipairs(cpus) do
    if cpus[i].busy = true then
        busy += 1
        print(busy)
    end
end
