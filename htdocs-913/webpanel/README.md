# Fivem Webmanager v2 [alpha]

Welcome back folks! It's been a long time since my last release. I am finally back to continue on what i once started and its better than ever. Please have in mind that this is still in heavy development and only the "most needed features" are aviable right now.

I decided to go with no sql (for now). to make it as easy as possible to set up.

## Files

You download the zip file and upload it to your webserver. Your server does need PHP!

## Configuration

 Everything you need to configure is in `/acp/inc/config.php`. There you can define the websites name, a security key for rcon stuff (**which you should change!**), your server(s), users that are allowed to login into your site and groups which will have "tags" behind the name (like admins, mods, donators, etc).

Open the file with an editor (notepad++ or any other) and change everything to your needings. You can add as many servers, groups and users as you want. 

**REMEMBER:** PHP arrays dont have a comma at the last line. You will save us all trouble if you dont put one there. :)



## Problems?
- Have you put a comma at the last line of an array? Remove it! 
- Does your server has PHP installed? Install it.
- You can not login? Did you create a hash and put it in the config?
- Someone can rcon your server? Change the securityKey.
- Something else is wrong? Come on, its not that hard to use your eyes and read an error. But if you cant find the problem, hit me up.
