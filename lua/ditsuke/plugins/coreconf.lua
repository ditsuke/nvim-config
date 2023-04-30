-- We need to self-load our config since Lazyvim does not pick it up due to our custom namespace (`ditsuke`)
require("ditsuke.config").init()

return {}
