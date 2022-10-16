# u0Launcher

Normally when you install unc0ver through TrollStore and try to jailbreak with it, it fails with a "Failed to disable codesigning" error because unc0ver expects amfid to be running in the background in order to patch it. However when unc0ver is installed through TrollStore, amfid doesn't get invoked in the unc0ver launch process because it launches through App Store fast path, which does not contact amfid for verification.

u0Launcher is an App that first sends an empty XPC message to amfid to make it start up and then jumps to unc0ver. This fixes the "Failed to disable codesigning" error when jailbreaking.

## How to use

1. Install unc0ver through TrollStore

2. Install u0Launcher through TrollStore

3. When jailbreaking, start the u0Launcher app instead of unc0ver, it will do the neccessary fix and then jump to unc0ver. Then you can press the "Jailbreak" button in the unc0ver app and it will work.