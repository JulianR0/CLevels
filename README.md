An AngelScript port of my custom SCXPM plugin.
## Why?
When Sven Co-op 5.00 came out, there was a lot of issues with Metamod/AMXX, to the point that my SCXPM frequently crashed the server. Because of this, I started to port the plugin to the new "AngelScript" language since day one. It was a bumpy road at first, since I had to rewrite thousands of lines of code with absolutely ZERO knowledge with the new language. This resulted with early bits of code that to this day still remains: An absolute mess that can be definitively rewritten in a better way.

However patience did it's thing at the end: This is the first working AngelScript port of SCXPM. Something unheard of, something that no one dared to do on the early days. Unfortunately I could not use this as bragging points since in those past times, this was a private plugin for the ImperiumSC servers. I choose to freely release the plugin to the public on March of 2018, in here, this very GitHub. But it was untranslated: The old "master" branch contains the unedited and "spanish" version of this port.

Now, it's nearly the end of 2020. I originally wanted to release this on XMas, but I guess I'll leave it to you as a "new year" gift, if you will. So here you go: An updated and translated version of my modified SCXPM. Enjoy! (If you can, because I know a lot of you hate SCXPM *>sadface*.)
## How old is this plugin?
Like I said before, it was a bumpy road. But eventually, I managed to get a mostly working SCXPM in AngelScript. And this was done as early as **February 2016**, that is Sven Co-op **5.01**! (Just shy of a few days before 5.02 update). It had lots of bugs and missing content, because AngelScript lacked a lot of features and was kinda buggy/glitchy on it's early days. As time progressed and AngelScript was updated, all remaining content that was missing on the SCXPM plugin was added.

The only thing that was missing was persistent file storage. You see, in the early days, the "store" folder did not exist. What good is an XP mod plugin if it cannot save player data? I regret to say that I held a grudge against the SC's developers for taking **10 months** to add that feature. Persistent file storage was added on 5.09. Imagine being a server operator and seeing your playerbase beg to you for their levels: They've been playing for years and their entire levels were gone, and see them dissapear from your community was devastating.

But that's all in the past, devs are cool now. Give them a hug, they need it.

I would love to tell you more but you'll grow bored.
## Getting started
For server operators, I built a barebones wiki containing instalation instructions, and how to configure it.

For casual players, the chat command `/menu` should provide you with all of your needs. A `/help` chat command displaying all commands is also available.
## Why is this repository called "CLevels"?
In the early days I had the fear that the server could transfer script files to clients with the **dlfile** console command, so I had to disguise the SCXPM plugin with a different name. CLevels wasn't a good mask but it did the trick. I was paranoid and didn't want my SCXPM to leak out there. **My plugin was already plagiarized once and that wasn't pretty.** So the filename was that: CLevels. Eventually I renamed it back to SCXPM, but I'm keeping the old repository name.
## How is this plugin different from a vanilla SCXPM?
- **No maximum level.** Players can level up for as long as they want. The same principle applies to medals too. However this does not mean that a player will eventually become overpowered. At a certain point, no more skillpoints will be given.
- **Nerfed skills.** A vanilla SCXPM let's you have 600+ HP/AP, or even beyond. This plugin has all skills nerfed and clamped: No player will be overpowered.
- **Special Skills.** Medals are very redundant on a vanilla SCXPM. Here, medals allow you to unlock additional skills.
- **Achievements.** Because we all at one point though of how would the game look like if it had achievements. Now you can answer that question.

There's more, but I'll leave it to you to find them.
## The code is horrible. You suck!
I already know that. I always sucked at code. And at english.
