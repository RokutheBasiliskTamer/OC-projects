--coded by RokutheBasiliskTamer

local term = require("term")
local component = require("component")
local event = require("event")
local rs = component.redstone
local modem = component.modem

--Config
local address = nil
local delay = 5
local port = 12

term.clear()
print("Enter the password")
input = text.trim(term.read(nil, false, nil, "*"))

modem.open(port)
modem.broadcast(port, input)

local _,_,mac,_,_,pull = event.pull(delay, "modem")

if address == nil then
address = mac

function door(incAddress, message)
if incAddress == address then
if message == "true" then
rs.setOutput(5, 15) -- this is sending a signal to the left change the number for the side you need
os.sleep(delay)
rs.setOutput(5, 0)

elseif message == "false" then
print ("Incorrect")
os.sleep(2)
os.execute("/home/bin/door.lua")
end
end
end



door(mac,pull)
