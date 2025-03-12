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
