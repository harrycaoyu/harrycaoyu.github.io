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

## Access to Hosting

The deployment mechanism for the site depends on SSH access to the machine that hosts the site. On virtual private servers, usually the hosting provider will give instructions as to how to obtain SSH access.

### AWS

Amazon explains how to obtain SSH access to an instance [here](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html).

### CPanel

On CPanel, go to the main dashboard, scroll down to **Security**, and click **SSH/Shell Access**. A window will pop up with the IP of your computer. Click "Submit", and the remote machine will allow access to itself via SSH from only your IP.

**NOTE**: You will likely need to repeat this process every time you access the remote machine from a different location because your computer's externally-visible IP will change.

# Deployment

The provided Makefile documents the different build and deployment options, and can show them by running:

    make help

or simply:

    make

The Makefile can upload the generated site using `rsync` to the configured server by running:

    make sync

The Makefile uses the following variables:

- USER
- SERVER
- REMOTE_DIR

to determine the user, server, and remote directory to which to copy the site. The values can be either changed in the Makefile directly, or changed on the command line like so:

    make sync USER=brizi SERVER=flybrizi.com REMOTE_DIR=/home/brizi/public_html/

Although the `sync` target uses the most efficient copying method, not all servers support `rsync`. In the case that a server does not support `rsync`, the Makefile can be told to use `scp` by substituting `sync` for either `copy_all` or `copy_src` by running:

    make copy_all

or:

    make copy_src

# Development

The Makefile has some convenient targets for testing. The website can be built and served locally (`localhost:4000`) with:

    make serve

However note that although the Jekyll development server watches for changes in the files and rebuilds the site, it does not re-run `lessc` to rebuild the CSS. The CSS needs to be rebuilt manually, with:

    make build

To remove the generated site and all CSS, run:

    make clean

**NOTE**: this command removes *all* CSS files under the CSS directory.

# References

* [Jekyll documentation](http://jekyllrb.com/docs/home/)
* [LESS documentation](http://lesscss.org/features/)
* [Bootstrap documentation](http://getbootstrap.com/)
* [Make documentation](http://www.gnu.org/software/make/manual/make.html)
