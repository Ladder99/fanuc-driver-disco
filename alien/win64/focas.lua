-- https://mascarenhas.github.io/alien/
-- https://milindsweb.amved.com/Lua_FFI.html
-- https://github.com/philips/beaming-up-alien/blob/master/alien-sqlite/demo.lua

ip = "127.0.0.1";
port = 8193;
timeout = 10;

if arg[1] then ip = arg[1] end;
if arg[2] then port = arg[2] end;
if arg[3] then timeout = arg[3] end;

print("target: " .. ip .. ":" .. port .. "," .. timeout);

alien = require("alien");
fw = alien.load("Fwlib64");

fw.cnc_allclibhndl3:types("short","string","ushort","long","pointer");
fw.cnc_freelibhndl:types("short","pointer");
fw.cnc_getpath:types("short","pointer","pointer","pointer");
fw.cnc_sysinfo:types("short","pointer","pointer");
fw.cnc_setpath:types("short","pointer","short");
fw.cnc_rdaxisname:types("short","pointer","pointer","pointer");
fw.cnc_rdspdlname:types("short","pointer","pointer","pointer");


hdl_ptr = alien.buffer(8);
path_ptr = alien.buffer(8);
max_path_ptr = alien.buffer(8);
sys_info_ptr = alien.buffer(8);

rc = fw.cnc_allclibhndl3(ip, port, timeout, hdl_ptr);
print("\trc_alloc: " .. rc);
hdl = hdl_ptr:get(1,"pointer");

rc = fw.cnc_getpath(hdl, path_ptr, max_path_ptr);
print("\trc_getpath: " .. rc);
paths = max_path_ptr:get(1,"short");
print("\tpaths: " .. paths);

for p=1,paths,1 do 
	rc = fw.cnc_setpath(hdl, p);
	print("\t\trc_setpath: " .. rc);
	print("\t\tpath: " .. p);

	rc = fw.cnc_sysinfo(hdl, sys_info_ptr);
	print("\t\t\trc_sysinfo: " .. rc);
	add_info = sys_info_ptr:get(1,"short");
	max_axes = sys_info_ptr:get(3,"short");
	cnc_type = sys_info_ptr:tostring(2,5);
	mt_type = sys_info_ptr:tostring(2,7);
	series = sys_info_ptr:tostring(4,9);
	version = sys_info_ptr:tostring(2,13);
	axes = tonumber(sys_info_ptr:tostring(2,17));
	print("\t\t\tsys: " .. 
			cnc_type .. "-" .. 
			mt_type .. "-" .. 
			series .. "-" .. 
			version ..
			", max_axes: " .. max_axes ..
			", axes: " .. axes .. 
			", addinfo: " .. add_info);

	axisnum_ptr = alien.buffer(8);
	axisnum_ptr:set(1,max_axes,"short");
	axisname_ptr = alien.buffer(8);
	rc = fw.cnc_rdaxisname(hdl, axisnum_ptr, axisname_ptr);
	print("\t\t\trc_rdaxisname: " .. rc);
	axisnum = axisnum_ptr:get(1,"short");

	offset = 1
	for a=1,axisnum,1 do 
		print("\t\t\taxis#: " .. a .. 
			", name: " .. axisname_ptr:tostring(2,offset));
		offset = offset + 2;
	end;

	spdlnum_ptr = alien.buffer(8);
	spdlnum_ptr:set(1,8,"short");
	spdlname_ptr = alien.buffer(8);
	rc = fw.cnc_rdspdlname(hdl, spdlnum_ptr, spdlname_ptr);
	print("\t\t\trc_spdlname: " .. rc);
	spdlnum = spdlnum_ptr:get(1,"short");

	offset = 1
	for s=1,spdlnum,1 do 
		print("\t\t\tspindle#: " .. s .. 
			", name: " .. spdlname_ptr:tostring(2,offset));
		offset = offset + 4;
	end;
end;

rc = fw.cnc_freelibhndl(hdl);
print("\trc_free: " .. rc);