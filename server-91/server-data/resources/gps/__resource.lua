resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
	"gps.lua",
}

ui_page('html/index.html')

files({
    'html/index.html',
    -- Begin Sound Files Here...
    -- client/html/sounds/ ... .ogg
		'html/voice/Straight.ogg',
		'html/voice/400meters.ogg',
		'html/voice/200meters.ogg',
		'html/voice/TurnLeft.ogg',
		'html/voice/TurnRight.ogg',
		'html/voice/KeepLeft.ogg',
		'html/voice/KeepRight.ogg',
})
