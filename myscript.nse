local nmap = require "nmap"
local stdnse = require "stdnse"

description = "What his script does"

categories = {"discovery"}

hostrule = function(host)
        return true
end

action = function(host)
        return "Hello ".. host.ip
end
