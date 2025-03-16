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

## Erlang/Elixir setup with ASDF

### [Blog](https://www.pluralsight.com/resources/blog/guides/installing-elixir-erlang-with-asdf)

### For various erlang features e.g. observer or wxWidgets see [asdf-erlang](https://github.com/asdf-vm/asdf-erlang?tab=readme-ov-file#before-asdf-install)

```bash
sudo apt install curl git
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
. $HOME/.asdf/asdf.sh # add both lines to ~/.bashrc
. $HOME/.asdf/completions/asdf.bash

asdf plugin add erlang (https://github.com/asdf-vm/asdf-erlang.git) optional url path
asdf plugin add elixir (https://github.com/asdf-vm/asdf-elixir.git) optional url path
asdf install
asdf list-all erlang
# ...
23.2
23.2.1
23.2.2
# ...
asdf install erlang 23.2.1
asdf list-all elixir
# ...
1.11.2
1.11.2-otp-21
1.11.2-otp-22
1.11.2-otp-23
# ...
asdf install elixir 1.11.2-otp-23
asdf local erlang 23.2.1
asdf local elixir 1.11.2-otp-23
asdf global erlang 23.2.1
asdf global elixir 1.11.2-otp-23

asdf list
elixir
 *1.15.3-otp-26
erlang
 *26.0
```

### [Phoenix Installation](https://hexdocs.pm/phoenix/installation.html)

```bash
mix archive.install hex phx_new

```
