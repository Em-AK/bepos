---
title: "How I automate my workstation configuration"
created_at: 2017-01-05
kind: article
lang: en
---

*intro*

## Steps

1. install an OS, [choose your flavor](distrowatch), I prefer archlinux or WattOS
2. install ansible, [follow the guide](http://docs.ansible.com/ansible/intro_installation.html)
3. edit `/etc/ansible/hosts` to tell ansible to execute locally without ssh:
  ```
    localhost ansible_connection=local
  ```
  At this point you should be able to ping yourself with `ansible all -m ping`
4. create a playbook suited to your needs, see em-ak/workstation
5. never use your packet manager any more, instead edit your playbook and version your config in git
6. Have fun. From now on if your laptop get smashed you can take any machine you like, stick in it your distro of choice, and get your beloved working station back in less than an hour. Yes you should do data backups... but this is another story !


{:refdef: .picture}
![](../../img/.png)
*legend*
{: refdef}

~ E.

*If you want to react, complement or question this article, ping [@em_hack](https://twitter.com/em_hack)*
