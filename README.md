# Flybrizi.com

This is the source code to the site hosted at [flybrizi.com](http://flybrizi.com). It is a Jekyll site, using Bootstrap for front-end code and GNU Make for deployment.

# Installation and setup

Jekyll needs to be installed to generate the site. Install Jekyll as described [here](http://jekyllrb.com/docs/installation/).

In addition, the site uses the LESS CSS preprocessor, which can be installed as described [here](http://lesscss.org/#using-less). If `npm` is unavailable, it can also be installed with `apt-get`:

    sudo apt-get install node-less

If `pip` is available, with:

    sudo pip install lesscss

And if `pip` is not around but Python is available, `pip` can be installed as described [here](http://pip.readthedocs.org/en/latest/installing.html).

GNU Make can be installed in too many different ways, but is usually present on most Unix-like systems. On Windows, MinGW or Cygwin come with Make.

Then to build the CSS and the site, run:

    make build

The CSS will be generated in the `css` directory, and the entire site will be built in the `_site` directory.

# Deployment

The provided Makefile documents the different build and deployment options, and can show them by running:

    make help

or simply:

    make

The Makefile can upload the generated site using `scp` or `rsync` to the configured server by running either one of the :

    make sync

The Makefile uses the following variables:

- USER
- SERVER
- REMOTE_DIR

to determine the user, server, and remote directory to which to copy the site. The values can be either changed in the Makefile directly, or changed on the command line like so:

    make sync USER=brizi SERVER=flybrizi.com REMOTE_DIR=/home/brizi/public_html/

Although the `sync` target uses the most efficient copying method, not all servers support `rsync`. In the case that a server does not support `rsync`, the Makefile can be told to use `scp` by substituting `sync` for either `copy_all` or `copy_src`.

# Development

The Makefile has some convenient targets for testing. The website can be built and served locally (`localhost:4000`) with:

    make serve

However note that although the Jekyll development server watches for changes in the files and rebuilds the site, it does not re-run `lessc` to rebuild the CSS. The CSS needs to be rebuilt manually, with:

    make build

To remove the generated site and all CSS, run:

    make clean

**NOTE**: this command removes *all* CSS files under the CSS directory.

# References

[Jekyll documentation](http://jekyllrb.com/docs/home/).<br>
[LESS documentation](http://lesscss.org/features/).<br>
[Bootstrap documentation](http://getbootstrap.com/).<br>
[Make documentation](http://www.gnu.org/software/make/manual/make.html).<br>
