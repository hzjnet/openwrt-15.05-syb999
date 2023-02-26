m = Map("ffmpegtool", translate("FFMPEG-Tool"))

m:section(SimpleSection).template  = "ffmpegtool_status"

s = m:section(TypedSection, "ffmpegtool", "", translate("Assistant for FFMPEG"))
s.anonymous = true
s.addremove = false

s:tab("ffmpegbasic", translate("Basic Setting"))

src_select=s:taboption("ffmpegbasic", ListValue, "src_select", translate("Source Select"))
src_select.placeholder = "one file"
src_select:value("one file",translate("one file"))
src_select:value("all files in the directory",translate("all files in the directory"))
src_select:value("rtmp stream",translate("rtmp stream"))
src_select.default = "one file"
src_select.rempty  = false

src_file_path=s:taboption("ffmpegbasic", Value, "src_file_path", translate("Source File Path"))
src_file_path:depends( "src_select", "one file" )
src_file_path.rmempty = true
src_file_path.datatype = "string"
src_file_path.default = "/mnt/sda1/input.mp3"

src_directory_path=s:taboption("ffmpegbasic", Value, "src_directory_path", translate("Source Directory Path"))
src_directory_path:depends( "src_select", "all files in the directory" )
src_directory_path.rmempty = true
src_directory_path.datatype = "string"
src_directory_path.default = "/mnt/sda1"

src_rtmp_path=s:taboption("ffmpegbasic", Value, "src_rtmp_path", translate("RTMP stream url"))
src_rtmp_path:depends( "src_select", "rtmp stream" )
src_rtmp_path.rmempty = true
src_rtmp_path.datatype = "string"
src_rtmp_path.default = "rtmp://ip:1935/stream"

dest_select=s:taboption("ffmpegbasic", ListValue, "dest_select", translate("Destination Select"))
dest_select.placeholder = "directory"
dest_select:value("directory",translate("directory"))
dest_select:value("Sound Card",translate("Sound Card"))
dest_select.default = "directory"
dest_select.rempty  = false

dest_directory_path=s:taboption("ffmpegbasic", Value, "dest_directory_path", translate("Destination Directory Path"))
dest_directory_path:depends( "dest_select", "directory" )
dest_directory_path.rmempty = true
dest_directory_path.datatype = "string"
dest_directory_path.default = "/mnt/sda1"

srcinfo = s:taboption("ffmpegbasic", Button, "srcinfo", translate("One-click Get infomation"))
srcinfo:depends( "audio_ready", "1" )
srcinfo.rmempty = true
srcinfo.inputstyle = "apply"
function srcinfo.write(self, section)
	luci.util.exec("sh /usr/ffmpegtool/getinfo >/dev/null 2>&1 &")
end

s:tab("audio_setting", translate("Audio Setting"))

audio_format=s:taboption("audio_setting", ListValue, "audio_format", translate("Audio format"))
audio_format.placeholder = "mp3"
audio_format:value("mp3")
audio_format:value("m4a")
audio_format:value("wmv")
audio_format:value("aac")
audio_format:value("ts")
audio_format:value("wav")
audio_format.default = "mp3"
audio_format.rempty  = false

sampling_rate=s:taboption("audio_setting", ListValue, "sampling_rate", translate("Sampling rate"))
sampling_rate.placeholder = "none"
sampling_rate:value("none")
sampling_rate:value("44100")
sampling_rate:value("22050")
sampling_rate:value("11025")
sampling_rate.default = "none"
sampling_rate.rempty  = false

audio_channel=s:taboption("audio_setting", ListValue, "audio_channel", translate("Audio channel"))
audio_channel.placeholder = "none"
audio_channel:value("none")
audio_channel:value("1",translate("mono"))
audio_channel:value("2",translate("stereo"))
audio_channel.default = "none"
audio_channel.rempty  = false

a_modify_duration=s:taboption("audio_setting", ListValue, "a_modify_duration", translate("Modify duration"))
a_modify_duration.placeholder = "do not modify"
a_modify_duration:value("do not modify",translate("do not modify"))
a_modify_duration:value("specific time period",translate("specific time period"))
a_modify_duration:value("cut head and tail",translate("cut head and tail"))
a_modify_duration.default = "do not modify"
a_modify_duration.rempty  = false

audio_starttime=s:taboption("audio_setting", Value, "audio_starttime", translate("Start time"))
audio_starttime:depends( "a_modify_duration", "specific time period" )
audio_starttime.datatype = "string"
audio_starttime.placeholder = "00:00:00.00"
audio_starttime.default = "00:00:00.00"
audio_starttime.rmempty = true

audio_endtime=s:taboption("audio_setting", Value, "audio_endtime", translate("End time"))
audio_endtime:depends( "a_modify_duration", "specific time period" )
audio_endtime.datatype = "string"
audio_endtime.placeholder = "00:01:30.00"
audio_endtime.default = "00:01:30.00"
audio_endtime.rmempty = true

audio_headtime=s:taboption("audio_setting", Value, "audio_headtime", translate("cut head"))
audio_headtime:depends( "a_modify_duration", "cut head and tail" )
audio_headtime.datatype = "string"
audio_headtime.placeholder = "15"
audio_headtime.default = "15"
audio_headtime.rmempty = true

audio_tailtime=s:taboption("audio_setting", Value, "audio_tailtime", translate("cut tail"))
audio_tailtime:depends( "a_modify_duration", "cut head and tail" )
audio_tailtime.datatype = "string"
audio_tailtime.placeholder = "10"
audio_tailtime.default = "10"
audio_tailtime.rmempty = true

risingfalling_tone=s:taboption("audio_setting", ListValue, "risingfalling_tone", translate("Rising-Falling tone"))
risingfalling_tone.placeholder = "none"
risingfalling_tone:value("none")
risingfalling_tone:value("sharp",translate("sharp"))
risingfalling_tone:value("rasing whole tone",translate("rasing whole tone"))
risingfalling_tone:value("flat",translate("flat"))
risingfalling_tone:value("falling whole tone",translate("falling whole tone"))
risingfalling_tone.default = "none"
risingfalling_tone.rempty  = false
risingfalling_tone.description = translate("increase CPU loading")

a_speed_governing=s:taboption("audio_setting", ListValue, "a_speed_governing", translate("Speed governing"))
a_speed_governing.placeholder = "none"
a_speed_governing:value("none")
a_speed_governing:value("0.5")
a_speed_governing:value("1.0")
a_speed_governing:value("1.5")
a_speed_governing:value("2.0")
a_speed_governing.default = "none"
a_speed_governing.rempty  = false
a_speed_governing.description = translate("increase CPU loading")

volume=s:taboption("audio_setting", ListValue, "volume", translate("Volume"))
volume.placeholder = "none"
volume:value("none")
volume:value("standard")
volume:value("+5dB")
volume:value("-5dB")
volume.default = "none"
volume.rempty  = false
volume.description = translate("increase CPU loading")

audio_title = s:taboption("audio_setting", Flag, "audio_title", translate("about title"))

audio_addtitle = s:taboption("audio_setting", Flag, "audio_addtitle", translate("set title"))
audio_addtitle:depends( "audio_title", "1" )
audio_addtitle.default = "0"

audio_titleisname = s:taboption("audio_setting", Flag, "audio_titleisname", translate("replace filename with title"))
audio_titleisname:depends( "audio_title", "1" )
audio_titleisname.default = "0"

audio_copy = s:taboption("audio_setting", Flag, "audio_copy", translate("Fast copy"))
audio_copy:depends({ risingfalling_tone = "none", a_speed_governing = "none", volume = "none", audio_title = "", sampling_rate = "none", audio_channel = "none" })

audio_ready = s:taboption("audio_setting", Flag, "audio_ready", translate("Setup ready"))
audio_ready.description = translate("Save/apply first please")

s:tab("video_setting", translate("Video Setting"))
video_format=s:taboption("video_setting", ListValue, "video_format", translate("Video format"))
video_format.placeholder = "mp4"
video_format:value("mp4")
video_format:value("mkv")
video_format:value("avi")
video_format:value("wmv")
video_format:value("ts")
video_format:value("3gp")
video_format.default = "mp4"
video_format.rempty  = false

video_x264 = s:taboption("video_setting", Flag, "video_x264", translate("using libx264 for mp4"))
video_x264:depends( "video_format", "mp4" )
video_x264.description = translate("increase CPU loading")

v_modify_duration=s:taboption("video_setting", ListValue, "v_modify_duration", translate("Modify duration"))
v_modify_duration.placeholder = "do not modify"
v_modify_duration:value("do not modify",translate("do not modify"))
v_modify_duration:value("specific time period",translate("specific time period"))
v_modify_duration:value("cut head and tail",translate("cut head and tail"))
v_modify_duration.default = "do not modify"
v_modify_duration.rempty  = false

video_starttime=s:taboption("video_setting", Value, "video_starttime", translate("Start time"))
video_starttime:depends( "v_modify_duration", "specific time period" )
video_starttime.datatype = "string"
video_starttime.placeholder = "00:00:00.00"
video_starttime.default = "00:00:00.00"
video_starttime.rmempty = true

video_endtime=s:taboption("video_setting", Value, "video_endtime", translate("End time"))
video_endtime:depends( "v_modify_duration", "specific time period" )
video_endtime.datatype = "string"
video_endtime.placeholder = "00:01:30.00"
video_endtime.default = "00:01:30.00"
video_endtime.rmempty = true

video_headtime=s:taboption("video_setting", Value, "video_headtime", translate("cut head"))
video_headtime:depends( "v_modify_duration", "cut head and tail" )
video_headtime.datatype = "string"
video_headtime.placeholder = "15"
video_headtime.default = "15"
video_headtime.rmempty = true

video_tailtime=s:taboption("video_setting", Value, "video_tailtime", translate("cut tail"))
video_tailtime:depends( "v_modify_duration", "cut head and tail" )
video_tailtime.datatype = "string"
video_tailtime.placeholder = "10"
video_tailtime.default = "10"
video_tailtime.rmempty = true

video_mute = s:taboption("video_setting", Flag, "video_mute", translate("Mute"))

video_picture = s:taboption("video_setting", Flag, "video_picture", translate("Save to picture"))
video_picture:depends({ src_select = "one file", video_x264 = "" })

video_frames = s:taboption("video_setting", Flag, "video_frames", translate("Set the number of frames"))

video_frames_num = s:taboption("video_setting", Value, "video_frames_num", translate("The number of frames"))
video_frames_num:depends( "video_frames", "1" )
video_frames_num.datatype = "range(1,25)"
video_frames_num.placeholder = "1"
video_frames_num.default = "1"
video_frames_num.rmempty = true

video_blackandwhite = s:taboption("video_setting", Flag, "video_blackandwhite", translate("black-and-white"))
video_blackandwhite.description = translate("increase CPU loading")

video_copy = s:taboption("video_setting", Flag, "video_copy", translate("Fast copy"))
video_copy:depends({ video_blackandwhite = "", video_x264 = "", video_picture = "" })

video_ready = s:taboption("video_setting", Flag, "video_ready", translate("Setup ready"))
video_ready.description = translate("Save/apply first please")

s:tab("action", translate("Action"))

audioaction = s:taboption("action", Button, "audioaction", translate("One-click Convert/Play/Output Audio"))
audioaction:depends( "audio_ready", "1" )
audioaction.rmempty = true
audioaction.inputstyle = "apply"
function audioaction.write(self, section)
	luci.util.exec("sh /usr/ffmpegtool/audioaction >/dev/null 2>&1 &")
end

audiostop = s:taboption("action", Button, "audiostop", translate("One-click STOP"))
audiostop:depends( "audio_ready", "1" )
audiostop.rmempty = true
audiostop.inputstyle = "apply"
function audiostop.write(self, section)
	luci.util.exec("kill -9 $(busybox ps | grep audioaction | grep -v grep | awk '{print$1}') >/dev/null 2>&1 ")
	luci.util.exec("kill $(busybox ps | grep ffmpeg | grep -v grep | awk '{print$1}') >/dev/null 2>&1 ")
	luci.util.exec("rm /tmp/ffmpeg.log 2>&1")
end

videoaction = s:taboption("action", Button, "videoaction", translate("One-click Convert/Play/Output Video"))
videoaction:depends( "video_ready", "1" )
videoaction.rmempty = true
videoaction.inputstyle = "apply"
function videoaction.write(self, section)
	luci.util.exec("sh /usr/ffmpegtool/videoaction >/dev/null 2>&1 &")
end

videostop = s:taboption("action", Button, "videostop", translate("One-click STOP"))
videostop:depends( "video_ready", "1" )
videostop.rmempty = true
videostop.inputstyle = "apply"
function videostop.write(self, section)
	luci.util.exec("kill -9 $(busybox ps | grep videoaction | grep -v grep | awk '{print$1}') >/dev/null 2>&1 ")
	luci.util.exec("kill $(busybox ps | grep ffmpeg | grep -v grep | awk '{print$1}') >/dev/null 2>&1 ")
	luci.util.exec("rm /tmp/ffmpeg.log 2>&1")
end

return m
