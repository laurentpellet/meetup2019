library(slackr)

slackrSetup(api_token = "xoxp-2723933153-2723933157-842625299124-c77fb12ce25455ac6f4eb09b2a164a0e")

slackr("Premier message", channel="#meetup2019")
ggslackr(ggMexicoMap,channels = "#meetup2019")

