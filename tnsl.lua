VERSION = "0.2.0"

local micro = import("micro")
local config = import("micro/config")
local fmt = import("fmt")
local uutil = import("micro/util")


function init()
	config.AddRuntimeFile("tnsl", config.RTSyntax, "syntax.yaml")
end

function onRune(bp, r)
	if bp.Buf:FileType() == "tnsl" then

		local curLine = bp.Buf:Line(bp.Cursor.Y)
		if bp.Cursor.X > 1 and (uutil.RuneAt(curLine, bp.Cursor.X - 2) == '/') then
			
			local close = uutil.RuneAt(curLine, bp.Cursor.X - 1)
			if close == ';' or close == ':' or close == '#' then
				
				bp.Buf:Insert(-bp.Cursor.Loc, close)
				bp.Buf:Insert(-bp.Cursor.Loc, '/')
				bp:CursorLeft()
				bp:CursorLeft()
			end
		end
	end
end
