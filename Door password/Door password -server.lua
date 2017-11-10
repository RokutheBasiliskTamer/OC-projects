--coded by RokutheBasiliskTamer

local comp = require("component")
local event = require("event")
local fs = require("filesystem")
local modem = comp.modem

--Config
local address = nil
local port = 12


if fs.exists("/home/bin/MAC.psd") then
reader = io.open("/home/bin/MAC.psd", "r")
address = reader: read("*a")
reader: close()

end

function firstTime()
print("Please enter your desired password")
input = io.read()
print("Please enter the password one more time")
input2 = io.read()
if input == input2 then
writer = io.open("/home/bin/data.psd", "w")

if comp.isAvailable("data") then
pass = comp.data.sha256(input)
writer: write(pass)
writer: close()

else
writer: write(input)
writer: close()

end

else
print("Those didn't match")
firstTime()
end

end

if not fs.exists("/home/bin/data.psd") then
firstTime()
end

modem.open(port)
print("Listening...")
local _,_,mac,_,_,pull = event.pull("modem")

if address == nil and mac then
address = mac
modem.send(address, port, "true")
writer = io.open("/home/bin/MAC.psd", "w")
writer: write(mac)
writer: close()

end

function door(incAddress,message)

if incAddress == address then

if comp.isAvailable("data") then
message = comp.data.sha256(message)

end

reader = io.open("/home/bin/data.psd", "r")
pass = reader: read("*a")


if pass == message then
modem.send(address, port, "true")
modem.close(port)
os.sleep(5)
os.execute("/home/bin/door.lua") --if you named it differently change that

else
modem.send(address, port, "false")
modem.close(port)
os.sleep(5)
os.execute("/home/bin/door.lua") --if you named it differently change that

end

reader: close()

end

end

door(mac, pull)
