# save the config to a file
vagrant ssh-config > vagrant-ssh

# run ssh with the file.
ssh -F vagrant-ssh default