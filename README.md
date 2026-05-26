An AngelScript port of my custom SCXPM plugin.
## Why?
When Sven Co-op 5.00 came out, there was a lot of issues with Metamod/AMXX, to the point that my SCXPM frequently crashed the server. Because of this, I started to port the plugin to the new "AngelScript" language since day one. It was a bumpy road at first, since I had to rewrite thousands of lines of code with absolutely ZERO knowledge with the new language. This resulted in early bits of code that to this day still remains: An absolute mess that can be definitively rewritten in a better way.

However patience did it's thing at the end: This is the first working AngelScript port of SCXPM. Something unheard of, something that no one dared to do on the early days. Unfortunately I could not use this as bragging points since in those past times, this was a private plugin for the ImperiumSC server.

On 2020 I translated the plugin to english, and now I can present to you: An updated and translated version of my modified SCXPM. Enjoy! (If you can, because I know a lot of you hate SCXPM.)
## How old is this plugin?
Very old, I guess? The first (mostly) working port of SCXPM in AngelScript I did was made as early as **2016**. More specifically Sven Co-op **5.01**. It had lots of bugs and missing content, mostly because AngelScript lacked a lot of features and was kinda buggy/glitchy on it's early days. As time progressed and AngelScript gained updates, the SCXPM plugin was able to mature into what it is now.

There were three reasons of why I didn't publicly release the plugin back then when the port was done. The first one was, as stated before, because this was originally a private plugin for the ImperiumSC servers. The second reason was because it was horribly coded and was unoptimized as hell (But I guess that didn't matter since I uploaded it here as-is in 2018). And the third reason was because persistent storage was missing. In the early days, the "store" folder did not exist. Meaning that all data you wanted to save had no guarantee of staying for long. What good is an XP mod plugin if it cannot save player data? Persistent storage was added **10 months** after Steam release, meaning that the plugin didn't see the light of the day for a very long time.
## Getting started
For server operators, I built a barebones wiki containing instalation instructions, and how to configure it.
For casual players, the chat command `/menu` should provide you with all of your needs. A `/help` chat command displaying all commands is also available.
## Why is this repository called "CLevels"?
In the early days I had the fear that the server could transfer script files to clients with the *dlfile* console command, so I had to disguise the SCXPM plugin with a different name. CLevels wasn't a good mask but it did the trick. I was paranoid and didn't want my SCXPM to get leaked. You see... **My plugin was already plagiarized once and that wasn't pretty.** So the filename was that: CLevels. Eventually I renamed it back to SCXPM, but I'm keeping the old repository name.
## How is this plugin different from a vanilla SCXPM?
- **No maximum level.** Players can level up for as long as they want. The same principle applies to medals too. However this does not mean that a player will eventually become overpowered. At a certain point, no more skillpoints will be given.
- **Nerfed skills.** A vanilla SCXPM let's you have 600+ HP/AP, or even beyond. This plugin has all skills nerfed and clamped by default: No player will be overpowered.
- **Special Skills.** Medals are very redundant on a vanilla SCXPM. Here, medals allow you to unlock additional skills.
- **Achievements.** Because we all at one point though of how would the game look like if it had achievements. Now you can answer that question.
- **Easily customizable.** Most aspects of this SCXPM can be easily changed by just changing a few lines, even without scripting skills.

There's more, but I'll leave it to you to find them.
## The code is horrible. You suck!
No need to tell me. I've always been a bad programmer.
