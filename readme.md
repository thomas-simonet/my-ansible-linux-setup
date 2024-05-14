# save the config to a file
vagrant ssh-config > vagrant-ssh

# run ssh with the file.
ssh -F vagrant-ssh default



# Fix "WARNING: UNPROTECTED PRIVATE KEY FILE!"

https://www.schakko.de/2020/01/10/fixing-unprotected-key-file-when-using-ssh-or-ansible-inside-wsl/



https://thedatabaseme.de/2022/02/20/vagrant-up-running-vagrant-under-wsl2/