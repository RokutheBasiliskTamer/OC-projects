--coded by RokutheBasiliskTamer

local term = require("term")
local component = require("component")
local text = require("text")
local event = require("event")
local fs = require("filesystem")
local sh = require("shell")
local rs = component.redstone
local modem = component.modem

--Config
local address = nil
local delay = 5
local port = 12

if fs.exists(sh.getPath("MAC.psd")) then
temp = io.open("address.psd", "r")
address = temp: read("*a")
temp: close()

term.clear()
print("Enter the password")
input = text.trim(term.read(nil, false, nil, "*"))

modem.open(port)
modem.broadcast(port, input)

local _,_,mac,_,_,pull = event.pull(delay, "modem")

if address == nil then
address = mac
temp = io.open("MAC.psd", "w")
temp: write(address)
temp: close()
end

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
