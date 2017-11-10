--coded by RokutheBasiliskTamer

local comp = require("component")
local event = require("event")
local modem = comp.modem

--Config
local password = false --set this to false and delete data.txt to reset password
local address = nil
local port = 12

function firstTime()
print("Please enter your desired password")
input = io.read()
print("Please enter the password one more time")
input2 = io.read()
if input == input2 then
password = true
temp = io.open("data.txt", "w")

if comp.isAvailable("data") then
pass = comp.data.sha256(input)
temp: write(pass)
temp: close()

else
temp: write(input)
temp: close()

end

else
print("Those didn't match")
firstTime()
end

end

if password == false then
firstTime()
end

modem.open(port)
local _,_,mac,_,_,pull = event.pull("modem")

if address == nil then
adress = mac

function door(incAddress,message)

if incAddress == address then

if comp.isAvailable("data") then
message = comp.data.sha256(message)

end

reader = io.open("data.txt", "r")
pass = reader: read("*a")


if pass == message then
modem.send(address, port, "true")
modem.close(port)
os.sleep(5)
os.execute("/home/bin/door.lua")

else
modem.send(address, port, "false")
modem.close(port)
os.sleep(5)
os.execute("/home/bin/door.lua")

end

reader: close()

end

end

door(mac, pull)
