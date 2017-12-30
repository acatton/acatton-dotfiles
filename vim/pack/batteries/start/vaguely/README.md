Vaguely
=======

Thin wrapper around `fzf`.

Name
----

"Vaguely" comes from the french "*vague*" which is the translation of "fuzzy"
into French. (which is also an English word)


How to install
--------------

Use Vim 8, and install it as a Vim 8 plugin. For example:

    $ git clone http://github.com/acatton/vaguely.vim ~/.vim/pack/vaguely/start/vaguely/

### pathogen, vundle, ...

I haven't tried any other package manager, and I will not support any other
myself. If anybody wants to do so, I will accept pull requests.


Why?
----

This plugins provides a thin wrapper around `fzf`, because the default
`fzf.vim` does things that **I** don't like. These things include:

  * Not being a git repository by itself that I can as a submodule in my dotfiles.

  * Downloading binary from the internet (namely fzf) and runing random code
    from the internet à la `curl | sh`. And running the `install.sh` which also
    modifies your `zshrc`, and other stuff.

  * The bigger `fzf.vim` wrapper is [written by Junegunn for junegunn.](https://github.com/junegunn/fzf.vim/pull/454#issuecomment-333041183)
    (Don't get me wrong on this, this is totally Junegunn's right. `fzf` itself
    is already awesome, and I thank Junegunn for that.)


Why not?
--------

This plugins misses many features that the original `fzf` has. They might be implemented at somepoint, they might be not.

  * `tmux` support
  * Microsoft® Windows® support
  * GVim (gui) support

Pull requests and patches for these features are welcomed.

How do I get `fzf`?
-------------------

**TL;DR:** You can get a [static binary from the internet](https://github.com/junegunn/fzf-bin/releases),
just put it in your local bin directory. (`~/.local/bin` or `/usr/local/bin` to taste)

The default fzf.vim script included in `fzf` downloads it from the internet and
install it from you (in addition to hooking into some of your system scripts)

The way I get it is that I commit the static binary in my dot-files. How I
generate this static binary, is the following:

I run:

    $ sudo docker run --rm -it golang
    container# CGO_ENABLED=0 GOOS=linux go get -u -a -ldflags '-extldflags "-static"' github.com/junegunn/fzf

And once this is done, before exiting the conainer, I do this in another terminal:

    $ sudo docker cp container:/go/bin/fzf .

Basically I compiled the binary statically myself in a docker container. You
can do that on the host, ... whatever, that's not my problem, just provide a
`fzf` executable to this vim plugin.

Donate and help
---------------

I personally do not want any of your money for my work on this plugin. Please
donate to [`fzf`](https://github.com/junegunn/fzf#readme) and
[Junegunn](https://github.com/junegunn) if you think this plugin is good. I
think Junegunn's work really deserves to be rewarded.

Pull requests, bugfixes, documentation improvements and issue reports are always
welcome from anybody, from any background, gender identity, skin color or
political affiliation. There's only one code of conduct: don't be a douche.
