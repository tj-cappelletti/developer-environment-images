# Developer Environment Images

## Available Images
| Image                      | Summary                                                     | Included Software             |
|:--------------------------:|-------------------------------------------------------------|-------------------------------|
| Windows 10 22H2 Enterprise | A generic Windows 10 image that has various developer tools | [Windows 10 22H2][win10-22h2] |

## ISO Web Server
If you are like me, you work off of multiple computers and ensuring that every ISO you might need is on every computer you own is challenging to say the least.
To solve this problem, I use the IODD ST400 external drive enclosure and ensure I have it with me at all times.
Craft Computing did a fantasic review about it and if you want to check it out, whatch their YouTube video [Never Flash a USB Drive Again - IODD ST400][craft-computing].

Since this is an external device and you are not guarnteed a drive letter each time you plug it in, both hard coding a path or creating a variable would mean constant editing of the repository.
To avoidt this, I run an NGINX container with it's content path mounted to my external drive.
If you are doing this from Windows, as am I, and your external drive letter is `H`, the following command would spin up an NGINX container serving your ISO files in the exact structure needed for the Packer files in this repository.

```
docker run -it --rm -d -p 8080:80 --name iso-web-server -v '/mnt/host/h:/usr/share/nginx/html' nginx
```

To help you quickly get up and running with this solution, here is the current structure of external drive so you can quickly leverage this repository.
```
/path/to/root/for/iso
├── win
├── ├── 10
|   |   ├ win_10_business_21h1_2022_12.iso
|   |   ├ win_10_business_21h2_2023_04.iso
|   |   ├ win_10_business_22h2_2023_04.iso
├── ├── 11
|   |   ├ win_11_business_21h2_2023_04.iso
|   |   ├ win_11_business_22h2_2023_04.iso
├── ├── 2019
|   |   ├ win_2019.iso
├── ├── 2022
|   |   ├ win_2022_2023_04.iso            
```

As long as the location you store your ISO file match the pathing I have above, you will be able to run an NGINX container and run `packer build` without having to change any files in this repository.

<!-- Links -->
[craft-computing]: https://www.youtube.com/watch?v=ZSywLblIYa0&ab_channel=CraftComputing "YouTube: Never Flash a USB Drive Again - IODD ST400"
[win10-22h2]: ./images/windows/win_10_enterprise/README.md "Windows 10 22H2"