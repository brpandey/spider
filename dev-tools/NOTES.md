## GIT config

```bash
git config --global user.name "Your Name"
git config --global user.email "youremail@domain.com"
git config --list
```

### SSH Keys

#### [Generating a new ssh key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

#### [Adding ssh pub key to Github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
> Enter a file in which to save the key (/home/YOU/.ssh/id_ALGORITHM):[Press enter]
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]

$ eval "$(ssh-agent -s)"
> Agent pid 59566
ssh-add ~/.ssh/id_ed25519

$ cat ~/.ssh/id_ed25519.pub
# Then select and copy the contents of the id_ed25519.pub file
# displayed in the terminal to your clipboard
# add pub key to Github

# Verify by running: ssh -T git@github.com
```

