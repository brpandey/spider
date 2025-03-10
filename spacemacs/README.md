# Installing spacemacs

sudo apt-get install emacs

mv .emacs .emacs.bak
mv .emacs.d .emacs.d.bak

git clone --recurse-submodules https://github.com/syl20bnr/spacemacs ~/.emacs.d

ln -s /home/brpandey/Workspace/github/spacemacs-file/.spacemacs .spacemacs

(or use gnu stow, .spacemacs should be read-only or chmod 0444 to do so, or chmod 0644 to write)

// If emacs is giving warnings, try:
export NO_AT_BRIDGE=1
