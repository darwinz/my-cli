#!/bin/sh

vpn_connect() {
    /usr/bin/osascript <<EOT
        tell application "Cisco AnyConnect Secure Mobility Client"
            activate
        end tell
        repeat until application "Cisco AnyConnect Secure Mobility Client" is running
            delay 1
        end repeat
        tell application "System Events"
            repeat until (window 1 of process "Cisco AnyConnect Secure Mobility Client" exists)
                delay 1
            end repeat
            tell process "Cisco AnyConnect Secure Mobility Client"
                keystroke ("vpn_domain" as string)
                keystroke return
                delay 1
                click button "Connect Anyway" of window 1
            end tell
            repeat until (window 2 of process "Cisco AnyConnect Secure Mobility Client" exists)
                delay 1
            end repeat
            tell process "Cisco AnyConnect Secure Mobility Client"
                keystroke ("vpn_password" as string)
		keystroke (tab) using {shift down}
		keystroke ("vpn_user" as string)
                keystroke return
                delay 1
                keystroke return
                keystroke "h" using {command down}
            end tell
        end tell
EOT
}
